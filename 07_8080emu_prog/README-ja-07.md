# 伝説の8080エミュレーター

## プログラム一覧

| No. | Source code | Explanation                            |
|:---:| ----------- | -------------------------------------- |
|  1  | sym80.mac   | エミュレーターシンボルUNV定義          |
|  2  | asm80.mac   | 8080命令マクロUNV定義                  |
|  3  | emu80.mac   | 命令エミュレート                       |
|  4  | emuiod.mac  | 入出力デバイスエミュレート（ダミー ）  |
|  5  | emuio.mac   | 入出力デバイスエミュレート             |
|  6  | obj80.mac   | オブジェクトコード出力                 |
|  7  | emu80.ctl   | エミュレータ構築バッチ制御             |
|  8  | main80.mac  | 8080サンプルプログラムコード           |
|  9  | mainsb.mac  | 8080基本入出力サブシステム             |


## アセンブル

### UNV定義のアセンブル （sym80.mac ／ asm80.mac）

| No. | Source code | Explanation                            |
|:---:| ----------- | -------------------------------------- |
|  1  | sym80.mac   | エミュレーターシンボルUNV定義          |
|  2  | asm80.mac   | 8080命令マクロUNV定義                  |

```
   @ macro
   
   *sym80,sym80=sym80
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 000000
   CPU TIME USED 00:00.017
   
   17P CORE USED
   
   *asm80,asm80=asm80
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 000000
   CPU TIME USED 00:00.026
   
   19P CORE USED
   
   * ^Z
   @
```

### エミュレーター（emu80.mac ,emuio.mac ,obj80.mac）

| No. | Source code | Explanation                            |
|:---:| ----------- | -------------------------------------- |
|  1  | emu80.mac   | 命令エミュレート                       |
|  2  | emuio.mac   | 入出力デバイスエミュレート             |
|  3  | obj80.mac   | オブジェクトコード出力                 |



```
   @ macro
   
   *emu80,emu80=emu80
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 001454
   CPU TIME USED 00:00.371
   
   73P CORE USED
   
   *emuio,emuio=emuio
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 000036
   CPU TIME USED 00:00.020
   
   72P CORE USED
   
   *obj80,obj80=obj80
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 000320
   CPU TIME USED 00:00.076
   
   74P CORE USED
   
   * ^Z
   @
```


### 8080プログラムコードのアセンブル（main80.mac ,mainsb.mac）

| No. | Source code | Explanation                            |
|:---:| ----------- | -------------------------------------- |
|  1  | main80.mac  | 8080サンプルプログラムコード           |
|  2  | mainsb.mac  | 8080基本入出力サブシステム             |

```
   @ macro
   
   *main80,main80=main80
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 000017
   CPU TIME USED 00:00.043
   
   21P CORE USED

   *mainsb,mainsb=mainsb
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 001027
   CPU TIME USED 00:00.069
   
   57P CORE USED
   
   * ^Z
   @
```

## 8080プログラム

### 8080サンプルプログラムコード （main80.mac）

```
       TITLE   MAIN80
       SEARCH  ASM80,SYM80
       ENTRY   MAIN80
       EXTERN  PORTINIT,OUTCHR
       EXTERN  END80,STACK
      .REQUIRE EMU80,MAINSB
   ;==================================
   COMMENT *
       8080 SAMPLE PROGRAM
       --------- ---- -- --------
       COPYRIGHT 2024 BY Y.TAKASE
       --------- ---- -- --------
   *
   ;==================================
       SALL
       RADIX 10
   MAIN80:
       LXI   SP,STACK
       CALL  PORTINIT  ; PORT INIT
   ;--------------------------------
       XRA   A         ; SUM=0
       MVI   B,1
       MVI   C,10      ; COUNT(10..1)
   LOOPX:
       ADD   B         ; SUM=SUM+B
       CALL  OUTSUM    ; OUT SUM (A)
       INR   B
       DCR   C
       JNZ   LOOPX
   EXIT:
       HLT
   ;=================================
   ; (I) A  : NUM
   OUTSUM:
      PUSH  PSW
      PUSH  B
   ;
      MOV   C,A
      MVI   A,"1"
   OUTLP:
      CALL  OUTCHR   ; OUTPUT CHAR (A)
      INR   A
      CPI   "9"+1
      JM    OUTSK
      MVI   A,"0"
   OUTSK:
      DCR   C
      JNZ   OUTLP
   ;
      MVI   A,13
      CALL  OUTCHR   ; OUTPUT CHAR (A is CR)
      MVI   A,10
      CALL  OUTCHR   ; OUTPUT CHAR (A is LF)
   ;
      POP   B
      POP   PSW
      RET
   ;
       END  
```

### 8080基本入出力サブシステム（mainsb.mac）

```
      TITLE   MAINSB - MAIN I/O BASIC 
      SEARCH  ASM80,SYM80
      SEARCH  MONSYM
      ENTRY   PORTINIT,OUTCHR,INPCHR
      ENTRY   END80,STACK
      SALL
      RADIX   10
   ;=============== PORT INIT
   PORTINIT:
      RET
   ;=============== OUTPUT CHAR
   ; (I) A  : CHAR
   OUTCHR:
      PUSH  PSW
      PUSH  B
      PUSH  D
      PUSH  H
   ;
      MOVE  AC1,R%AA
      PBOUT%
   ;
      POP   H
      POP   D
      POP   B
      POP   PSW
      RET
   ;
   ;=============== INPUT CHAR
   ; (O) A  : CHAR
   INPCHR:
      PUSH  B
      PUSH  D
      PUSH  H
   ;
      PBIN%
      MOVE  R%AA,AC1
   ;
      POP   H
      POP   D
      POP   B
      RET
   ;===================================
   END80:
   ;-- ASCIZ PROG NAME --
       ASCIZ /SUM.OBJ/   
   ;=================== STACK
   STACKS:
       DS 512
   STACK:
      END
```

## EXECコマンドで実行

```
   @exec main80.mac
   LINK:   Loading
   [LNKXCT EMU80 execution]
   EMU8080 START
   1
   123
   123456
   1234567890
   123456789012345
   123456789012345678901
   1234567890123456789012345678
   123456789012345678901234567890123456
   123456789012345678901234567890123456789012345
   1234567890123456789012345678901234567890123456789012345
   
   HALT!
   @
```


