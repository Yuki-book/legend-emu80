[TOP README](../README-ja.md)

# Altair 数式電卓

## Description

『超マシン復活 #4 DEC TOPS-20 伝説の8080エミュレーターとALTAIR』
第7章に掲載の**Altair 数式電卓**です。
Altair simHで動作します。

## プログラム一覧

| No. | Source code | Explanation                            |
|:---:| ----------- | -------------------------------------- |
|  1  | CALC.PTR    | 数式電卓の8080オブジェクトコード       |
|  2  | altairz80   | Altairシミュレーター本体               |
|  3  | boot.cmd    | Altairマシンの設定                     |
|  4  | boot.oct    | ブートローダのコード                   |


## Altair 数式電卓の実行

### ブートローダの実行


```
   $ ./altairz80 boot.cmd
   
   Altair 8800 (Z80) simulator V4.0-0 Current
   PTR
           Status port = 0x12
             Data port = 0x13
   
           attached to CALC.PTR
   
   HALT instruction, PC: 00048 (HLT)
   sim>
```

### 数式電卓の実行

```
   sim> go
   Formula calculator start!
   ? 2+2
                   ANSER=4 [0004]
   ? 2+3*4
                   ANSER=14 [000E]
   ? 100/11
                   ANSER=9 [0009]
   ? 100%11
                   ANSER=1 [0001]
   ? 100-(100/11*11)
                   ANSER=1 [0001]
   ?
   Goodbye
   
   HALT instruction, PC: 000AE (HLT)
   sim> quit
   Goodbye
   $
```

