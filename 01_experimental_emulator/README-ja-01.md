[Top README is here](../README-ja.md)
________________________________________________

legend-emu80
============

# 実験的なエミュレーター 

## Description

『超マシン復活 #4 DEC TOPS-20 伝説の8080エミュレーターとALTAIR』
第3章に掲載の**実験的なエミュレーター**です。
PDP-10 TOPS-20で動作します。


## プログラム一覧

| No. | Source code | Explanation           |
|:---:| ----------- | --------------------- |
|  1  | trysym.mac  | 8080マクロUNV定義     |
|  2  | trym80.mac  | 8080プログラムコード  |
|  3  | tryxct.mac  | 8080命令エミュレート  |



## アセンブル

### UNV定義のアセンブル（trysym.mac）

```
   @ macro
   
   *trysym,trysym=trysym
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 000000
   CPU TIME USED 00:00.019
   
   17P CORE USED
   
   * ^Z
   @
```

### 8080プログラムコードのアセンブル（trym80.mac）

```
   @ macro
   
   *trym80,trym80=trym80
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 000000
   ABSOLUTE BREAK IS 000212
   CPU TIME USED 00:00.025
   
   19P CORE USED
   
   * ^Z
   @
```

## 8080プログラム

### 8080ソースプログラム（trym80.mac）

```
       TITLE  TRYM80
       SEARCH TRYSYM
       ENTRY  MAIN80
       SALL
       RADIX 10
   ;-------------------- MAIN
       ORG  128
   MAIN80:
       LDA  W1
       CMA  
       STA  W2
       HLT
   W1: DB   128
   W2: DB   0
       END  
```

### 8080リストプログラム（trym80.lst）

```
   TRYM80        MACRO %53B(1254)-4 11:43 19-May-22 Page 1
   TRYM80  MAC      1-Oct-21 19:54
   
                                               TITLE  TRYM80
                                               SEARCH TRYSYM
                                               ENTRY  MAIN80
                                               SALL
                                               RADIX 10
                                           ;-------------------- MAIN
           000200                              ORG  128
           000200                          MAIN80:
           000200  001000  000072              LDA  W1
           000201  000000  000210
           000202  000000  000000
           000203  001000  000057              CMA
           000204  001000  000062              STA  W2
           000205  000000  000211
           000206  000000  000000
           000207  001000  000166              HLT
           000210  000000  000200          W1: DB   128
           000211  000000  000000          W2: DB   0
                                               END
   
   NO ERRORS DETECTED
   
   PROGRAM BREAK IS 000000
   ABSOLUTE BREAK IS 000212
   CPU TIME USED 00:00.019
   
   17P CORE USED
   TRYM80        MACRO %53B(1254)-4 11:43 19-May-22 Page S-1
   TRYM80  MAC      1-Oct-21 19:54         SYMBOL TABLE
   
   MAIN80          000200  ent
   OP%CMA          000057
   OP%HLT          000166
   OP%LDA          000072
   OP%STA          000062
   UUO             001000
   W1              000210
   W2              000211
   
   
   @
```

## EXECコマンドで実行

```
   @ exec trym80.mac,tryxct.mac
   MACRO:  TRYXCT
   LINK:   Loading
   [LNKXCT TRYXCT execution]
   @ ddt
   DDT
   w1[   200
   w2[   177
   
    ^C
   @
   
```

## DEBUGコマンドでデバッグ

```
   @ debug trym80.mac,tryxct.mac
   LINK:   Loading
   [LNKDEB DDT execution]
   DDT
   
   stop$b
   $g
   $1B>>STOP#/   HALTF%
   w1[   200
   w2[   177
   
    ^C
   @
```

