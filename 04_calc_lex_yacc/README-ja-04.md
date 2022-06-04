[Top README is here](../README-ja.md)
________________________________________________

legend-emu80
============

# 数式電卓 lex / yacc

## Description

『超マシン復活 #4 DEC TOPS-20 伝説の8080エミュレーターとALTAIR』
第5章(5.1)に掲載の**数式電卓 lex / yacc**です。
Linuxで動作します。

## プログラム一覧

| No. | Source code | Explanation                            |
|:---:| ----------- | -------------------------------------- |
|  1  | scalc.l     | 数式電卓 字句解析                      |
|  2  | scalc.y     | 数式電卓 構文解析                      |


## 数式電卓の実行

### ビルド

```
   $ yacc scalc.y
   $ lex scalc.l
   $ cc y.tab.c -ly -ll -o scalc
   $
```

### 数式電卓の実行

```
   $ ./scalc
   Formula calculator start!
   ? 14-3*4
                   ANSER=2         [0002]
   ? 3*(5+1)
                   ANSER=18        [0012]
   ?
   Goodbye
   $
```

