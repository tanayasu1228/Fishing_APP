## ANGLER
【トップ画面の全体画像】
![angler-app herokuapp com_ (1)](https://user-images.githubusercontent.com/61640081/107223916-1cefa380-6a5a-11eb-9777-1ebd5a7ba2c9.png)

## アプリの概要
オリジナルの大会を簡単に開催して、釣りする時間帯に制限のある方も気軽に参加できる釣りアプリです。

詳細な情報は下記をご覧ください
[Qiita:ポートフォリオの解説](https://qiita.com/tanayasu1228/items/845492517576ad628f5e)

## URL
下記のページで公開しています
https://angler-app.herokuapp.com/

* テストの場合はゲストユーザーとしてログインできます。
* スマートフォンからもご覧いただけます。




## 使用技術
* Ruby 2.6.6, Rails 6.0.3.2
* PostgreSQL 13.0
* AWS S3
* HTML, Sass, javascript, jQuery

## 使い方
### 大会の新規作成
1.開催期間や釣り場、釣りスタイル、ルールなどをボタンで選択。（魚の長さや釣果数で競います）
2.対象魚を選択（対象魚が無い場合や複数魚種の場合にテキスト入力から指定できる）
### GPSチェック
1.位置情報付き画像かどうかを確認できます。
### 大会へ投稿
1.開催中の大会にエントリーした状態で投稿ボタンが表示されます。
2.位置情報付きの写真を投稿できます。


## 機能一覧
* ユーザー登録・ログイン機能・ゲストログイン機能
* 投稿機能（画像のアップロードにCarrierWaveを使用）
* 画像のGPSのメタデータを取得（EXIFRを使用）
* 大会一覧（開催中 or 開催予定 or 開催後）の切り替え（JQueryを使用）
* ランキング機能（大会ルールによって表示の変化・同率順位で処理しています）
* ページネーション機能（Kaminari）
* いいね機能（Ajax）
* コメント投稿・削除（Ajax）
* 釣れた場所の地図表示機能（google map API・geocoderを使用）
追加内容：（使ってもらった友人の意見から「ピンポイントは知られたくない」意見があったため円を使って広範囲表示に切り替えました）
* PV回数の表示(impressionistを使用)

## ER図
<img width="635" alt="スクリーンショット 2021-02-09 23 02 41" src="https://user-images.githubusercontent.com/61640081/107374479-fa798b00-6b2a-11eb-9470-95be44da34f3.png">

## 課題、今後実装したい機能
* 個人釣果データを集計＆分析できるようにグラフ化
* 釣果投稿にAPIを使用して天候を付け加える
* ルール違反発見時の報告機能と対策機能
* AWSへデプロイ

## 作者
[：Twitter](https://twitter.com/tanahashi_yasu)
E-Mail: [tana.yasu1228@gmail.com](tana.yasu1228@gmail.com)
