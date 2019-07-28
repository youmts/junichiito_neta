# give IT a tryのプログラミング問題の回答

[アウトプットのネタに困ったらこれ！？Ruby初心者向けのプログラミング問題を集めてみた（全10問）](https://blog.jnito.com/entry/2019/05/03/121235)
のうちの面白そうな5問を回答したものです。全体的におよそ一時間でリファクタリングまで済ませるようにやってみました。RSpecも時間の許す限り、できるだけ書きました。

## ガラケー文字入力問題

https://github.com/youmts/junichiito_neta/blob/master/lib/garake_simulator.rb

60分でコアロジックが完成。10分で標準入出力を作成。

## 行単位、列単位で合計値を求めるプログラム

https://github.com/youmts/junichiito_neta/blob/master/lib/sum_matrix.rb

30分でコアロジックが完成、40分で標準出力に出力する部分を作成(むしろこっちに苦労した感じ)。

## カラオケマシン問題

https://github.com/youmts/junichiito_neta/blob/master/lib/karaoke_machine.rb

60分で完成しました。

## 国民の祝日.csv パースプログラム

https://github.com/youmts/junichiito_neta/blob/master/lib/holiday_parser.rb

60分で完成しました。

## 「Rubyで英語記事に含まれてる英単語を数えて出現数順にソートする」問題

https://github.com/youmts/junichiito_neta/blob/master/lib/english_counter.rb

180分かかりました。。。テストを通すだけなら120分くらいでしたが、あまりに可読性がわるいのでリファクタリングしました。これだけ複雑になるともう少し処理を分解してテストコードも増やしたい感じですが、そこまで手が回っていません。

## 全体的な感想

junichiitoさんの回答もさらっと眺めてみたのですが、私は文字列解析のときに正規表現の使いっぷりが少ないように思えます。正規表現に任せるとシンプルに、かつ素早く実装できそうですので意識して使うようにしたいですね。