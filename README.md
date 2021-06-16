# アプリケーション概要
TECH CAMPの最終課題として実装したフリマアプリのコピーサイト。  
DB設計、開発、テスト、デプロイを独力で行い、メンターへの質問も制限される中で実装した。各機能実装ごとにコードレビューしてもらい、問題なければ次の機能の実装を行うという流れで行った。  
機能としてはユーザー管理機能（新規登録・ログイン・ログアウト機能）、商品出品機能（出品・編集・削除機能）、商品購入機能（クレジットカード決済機能）を実装。  
※コメント機能は未実装  
画像はAmazonのクラウドストレージサービス「S3」を利用して保存している。  
Basic認証を導入。  
ユーザー名：admin  
パスワード：2222  
https://furima-34566.herokuapp.com/

# テーブル設計

## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| last_name          | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name         | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :buyers
- has_many :comments

## itemsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false                    |
| description | text       | null: false                    |
| category_id | integer    | null: false                    |
| status_id   | integer    | null: false                    |
| burden_id   | integer    | null: false                    |
| area_id     | integer    | null: false                    |
| days_id     | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |
| price       | integer    | null: false                    |

### Association

- belongs_to :user
- has_one :buyer
- has_many :comments

## buyersテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user            | references | null: false, foreign_key: true |
| item            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one: order

## ordersテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | string     | null: false                    |
| area_id         | integer    | null: false                    |
| city            | string     | null: false                    |
| address         | string     | null: false                    |
| building        | string     |                                |
| phone_num       | string     | null: false                    |
| buyer           | references | null: false, foreign_key: true |

### Association

- belongs_to :buyer

## commentsテーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| text    | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item