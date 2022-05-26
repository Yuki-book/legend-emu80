[TOP README](../README-ja.md)

# 伝説の8080エミュレーター

## Description

『超マシン復活 #4 DEC TOPS-20 伝説の8080エミュレーターとALTAIR』
第4章と第6章に掲載の**伝説の8080エミュレーター**です。
PDP-10 TOPS-20で動作します。


## プログラム一覧

| No. | Source code | Explanation                            |
|:---:| ----------- | -------------------------------------- |
|  1  | sym80.mac   | エミュレーターシンボルUNV定義          |
|  2  | asm80.mac   | 8080命令マクロUNV定義                  |
|  3  | emu80.mac   | 命令エミュレート                       |
|  4  | emuiod.mac  | 入出力デバイスエミュレート（ダミー ）  |
|  5  | emuio.mac   | 入出力デバイスエミュレート             |
|  6  | obj80.mac   | オブジェクトコード出力                 |
|  7  | main80.mac  | 8080プログラムコード                   |


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

### エミュレーター（emu80.mac ,emuiod.mac ,obj80.mac）

| No. | Source code | Explanation                            |
|:---:| ----------- | -------------------------------------- |
|  1  | emu80.mac   | 命令エミュレート                       |
|  2  | emuiod.mac  | 入出力デバイスエミュレート（ダミー ）  |
|  3  | obj80.mac   | オブジェクトコード出力                 |

【注意】emuiod.macをアセンブルしてemuio.relを作成します。


```
   @ macro
   
   *emu80,emu80=emu80
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 001454
   CPU TIME USED 00:00.371
   
   73P CORE USED
   
   *emuio,emuiod=emuiod
   
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


### 8080プログラムコードのアセンブル（main80.mac）

| No. | Source code | Explanation                            |
|:---:| ----------- | -------------------------------------- |
|  1  | main80.mac  | 8080プログラムコード                   |

```
   @ macro
   
   *main80,main80=main80
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 000017
   CPU TIME USED 00:00.043
   
   21P CORE USED
   
   * ^Z
   @
```

## 8080プログラム

### 8080ソースプログラム（main80.mac）

```
       TITLE   MAIN80
       SEARCH  ASM80,SYM80
       ENTRY   MAIN80,END80
      .REQUIRE EMU80
   ;=========================
       SALL
       RADIX 10
   ;-------------------- MAIN
   MAIN80:
       XRA   A
       MVI   C,10
   LOOP:
       ADD   C
       DCR   C
       JNZ   LOOP
       STA   SUM
   EXIT:
       HLT
   SUM:
       DB    0
   END80:
   ;-- ASCIZ PROG NAME --
       ASCIZ /SUM.OBJ/   
       END  
```

### 8080リストプログラム（main80.lst）

```
   MAIN80        MACRO %53B(1254)-4 12:33 19-May-22 Page 1
   MAIN80  MAC     19-May-22 12:32
   
                                               TITLE   MAIN80
                                               SEARCH  ASM80,SYM80
                                               ENTRY   MAIN80,END80
                                              .REQUIRE EMU80
                                           ;=========================
                                               SALL
                                               RADIX 10
                                           ;-------------------- MAIN
           000000'                         MAIN80:
           000000' 001000  000257              XRA   A
           000001' 002000  000016              MVI   C,10
           000002' 000000  000012
           000003'                         LOOP:
           000003' 001000  000201              ADD   C
           000004' 001000  000015              DCR   C
           000005' 003000  000302              JNZ   LOOP
           000006' 000000000000#
           000007' 000000000000#
           000010' 003000  000062              STA   SUM
           000011' 000000000000#
           000012' 000000000000#
           000013'                         EXIT:
           000013' 001000  000166              HLT
           000014'                         SUM:
           000014' 000000  000000              DB    0
           000015'                         END80:
                                           ;-- ASCIZ PROG NAME --
           000015' 123 125 115 056 117         ASCIZ /SUM.OBJ/
           000016' 102 112 000 000 000
                                               END
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 000017
   CPU TIME USED 00:00.042
   
   21P CORE USED
   MAIN80        MACRO %53B(1254)-4 12:33 19-May-22 Page S-1
   MAIN80  MAC     19-May-22 12:32         SYMBOL TABLE
   
   A               000007
   ADD%OP          000200
   C               000001
   DCR%OP          000005
   END80           000015' ent
   EXIT            000013'
   HLT%OP          000166
   JNZ%OP          000302
   LOOP            000003'
   MAIN80          000000' ent
   MVI%OP          000006
   STA%OP          000062
   SUM             000014'
   UUO1            001000
   UUO2            002000
   UUO3            003000
   XRA%OP          000250
```

## EXECコマンドで実行

```
   @ exec main80.mac
   LINK:   Loading
   [LNKXCT EMU80 execution]
   EMU8080 START
   
   HALT!
   @ ddt
   DDT
   sum[   67
   $$10r        
   sum[   55.
   
    ^C
   @
```

## DEBUGコマンドでデバッグ

```
   @ debug main80.mac
   LINK:   Loading
   [LNKDEB DDT execution]
   DDT
   exit$b
   $g
   EMU8080 START
   $1B>>EXIT#/   UUO1#,,HLT%OP#
   
   sum[   67
   $$10r
   sum[   55.
   
   end80/   HRLZM P3,@527220(P2)
   $$t
   end80/   SUM.O
   
     ^C
   @
```

## オブジェクトコード出力

```
   @ exec main80.mac
   LINK:   Loading
   [LNKXCT EMU80 execution]
   EMU8080 START
   
   HALT!
   @ continue
   OBJ8080 START
   SUM.OBJ  S: 00140  E: 00154
   DONE
   
   @ type sum.obj
   257,016,012,201,015,302,143,000,
   062,154,000,166,067$
   
   @
```

# エンハンスド・エミュレーター

### エミュレーター（emu80.mac ,emuio.mac ,obj80.mac）

| No. | Source code | Explanation                            |
|:---:| ----------- | -------------------------------------- |
|  1  | emu80.mac   | 命令エミュレート                       |
|  2  | emuio.mac   | 入出力デバイスエミュレート             |
|  3  | obj80.mac   | オブジェクトコード出力                 |


emuio.mac をアセンブルしてemuiod.macと入れ替える。

```
   @ macro
   
   *emuio,emuio=emuio
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 000130
   CPU TIME USED 00:00.099
   
   55P CORE USED
   
   * ^Z
   @
```


