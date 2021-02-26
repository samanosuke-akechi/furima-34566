# テーブル設計

## usersテーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| email            | string | null: false |
| password         | string | null: false |
| nickname         | string | null: false |
| last_name_kanji  | string | null: false |
| last_name_kana   | string | null: false |
| first_name_kanji | string | null: false |
| first_name_kana  | string | null: false |
| birthday         | date   | null: false |

### Association

- has_many :items
- has_one :buyer
- has_many :comments

## itemsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false                    |
| image       |            |                                |
| description | text       | null: false                    |
| category    | string     | null: false                    |
| status      | string     | null: false                    |
| burden      | string     | null: false                    |
| area        | string     | null: false                    |
| days        | string     | null: false                    |
| user        | references | null: false, foreign_key: true |
| price       | integer    | null: false                    |

### Association

- belongs_to :user
- has_one :buyer
- has_many :comments

## buyersテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| card_num        | integer    | null: false                    |
| expiration_date | integer    | null: false                    |
| cvv             | integer    | null: false                    |
| postal_code     | integer    | null: false                    |
| state           | string     | null: false                    |
| city            | string     | null: false                    |
| address         | string     | null: false                    |
| building        | string     |                                |
| phone_num       | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |
| item            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## commentsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item