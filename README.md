# ※レビュー済みでありダメな例です．みなさまは決して参考にしないように推奨します．
# バグなしで一通り動作します．
# iOS-Kadai-ver2

## 概要

本プロジェクトは株式会社ゆめみ様が、iOS エンジニアを希望する方に出す課題のベースプロジェクトです。インターン申込再挑戦のため、概要を詳しく読んだ上で課題に取り組みました．

## アプリ仕様

本アプリは GitHub のリポジトリーを検索するアプリです。

### 環境

- IDE：Version 13.4.1 (13F100)
- Swift：Apple Swift version 5.6.1
- 開発ターゲット：iOS 15.5

### 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示

## 前回の挑戦で取り組んだ課題
### 1.ソースの可読性向上
- 命名規約（参考：Swift API Design Guidelines）

[`参考1`](https://qiita.com/fuwamaki/items/f2df71723ab277dffc29) :Swiftの命名規則を理解する（Swift API Design Guidelines - Naming 日本語まとめ）

[`参考2`](https://www.swift.org/documentation/api-design-guidelines/#naming) :swift.org（Naming）
をみながら対策を行なった．


- ネスト

[`参考1`](https://techblog.recochoku.jp/8058) :【Swift】安全にアンラップするために 〜!（強制アンラップ）とif letとguard letと??（Nil coalescing operator）の使い分け〜
guard let ~ else {return} を使用し，if文による深いネストを極力避けた．


- インデント
    対策を行なった．
- コメントの適切性
    関数としてまとめた機能含め，わかりにくい動作の補足を行なった．
- スペースや改行
    書き方を統一した．
- その他
    処理を関数としてまとめ，Viewの動作を行う処理が長くなってしまわないよう対処した．


### 2.ソースコードの安全性の向上
guard let ~ else {return} を使用し，以下の項目に対応した．
- 強制アンラップ
- 強制ダウンキャスト
- 不必要なIUO
- 想定外の nil の握り潰し

[`参考1`](https://techblog.recochoku.jp/8058) :【Swift】安全にアンラップするために 〜!（強制アンラップ）とif letとguard letと??（Nil coalescing operator）の使い分け〜

### 3.バグを修正
- レイアウトエラー
stackviewの位置が定まっていなかったので修正.
- メモリリーク
クロージャによる循環参照が原因でメモリリークが発生するようです．以下の記事を参考に[weak self]追加で対処．
[`参考1`](https://tm-progapp.hatenablog.com/entry/2021/01/21/215819) : Swiftで循環参照によるメモリリークを起こしてしまった話
- パースエラー
ViewController2.swiftにて,閲覧者数を取得するキーワード"wathcer_count"がtypo.修正済みだが，APIの仕様変更により，現在このキーワードで取得できるのはスター数とのことでした．

### 4.FatVC
GitAPIの処理がViewController内に記述されていたので，GithubData.swiftへの切り出しを行い対処

### 5.その他
ViewController.swift,ViewController2.swift→SearchViewController.swift, DetailViewController.swiftに名前変更

## 以下今回の改善点及びアピールポイント
### 6.前回の改善点への対応
 - urlSessionTaskのresumeとreloadDataの切り離し(GithubDataへの切り離し)のバグ→ NotificationCenterの導入により，バグを解決
 -  UISearchBarの表示テキスト→placeholderを使用し設定
 -  文字列や配列の空チェック→countでなく、isEmptyを使用
 -  DetailViewControllerがSearchViewControllerの参照を持っているが不要→見直したところその通りでありました．参照削除済み
 -  Cell→dequeueReusableCellを使用することでCellの再利用を行えるよう変更
 -  ダークモードへの対応→[`こちら`](https://qiita.com/gonsee/items/c04b73787730c0e831df)を参考にdynamicColorを導入し，動的にラベルの色を変更
 -  小さい端末や横画面時に詳細画面の表示ができない→UIScrollView及びAuto Layoutによりシミュレータ上最も小さな端末(iPhone8,SE)から最も大きな端末(iPad Pro 12.9inch(5generation))まで全てにおいて動作するように改善，横画面表示も対応([`参考1`](https://swallow-incubate.com/archives/blog/20200805))([`参考2`](https://qiita.com/ynakaDream/items/960899183c38949c2ab0))([`参考3`](https://type.jp/et/feature/3112/))([`参考4`](https://developer.apple.com/documentation/uikit/uiscrollview))
 - 以上，前回指摘していただいた全ての改善点に対応しました．

### 7.オリジナリティ
 - UXを意識し，全ての動作を縦スクロールのみで完結するよう「Present Modally」による画面遷移に変更しました．

### 8.今後の課題
 - GithubDataのユニットテストの導入
 - GithubDataに対するprotocolを定義し，スタブを作成した上でUIテストを導入
 - MVCなどのアーキテクチャの導入

### 9.今回の再学習にあたっての参考文献
[`Swift実践入門`](https://gihyo.jp/book/2020/978-4-297-11213-4)
[`iOSアプリ設計パターン入門`](https://peaks.cc/books/iOS_architecture)

### 10.コメント
時間はかかってしまいましたが，本課題を通じてSwift/Xcodeに大分慣れることができました．今回は絶対にコードレビューに受かるぞ！という気持ちで，前回いただいたコードレビューを参考に一生懸命制作いたしました．伸び代には自信があります！宜しくお願い致します！
