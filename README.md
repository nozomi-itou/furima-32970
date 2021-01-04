# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

### Association
- has_many :items
- has_many :customers
- has_many :orders



## items テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false                    |
| details     | text       | null: false                    |
| category_id | text       | null: false                    |
| status_id   | text       | null: false                    |
| postage_id  | text       | null: false                    |
| area_id     | text       | null: false                    |
| days_id     | text       | null: false                    |
| price       | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- has_one :orders



## customers テーブル
| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| post_code_id    | string     | null: false                    |
| prefecture_id   | string     | null: false                    |
| city            | string     | null: false                    |
| address         | string     | null: false                    |
| building_name   | string     |                                |
| phone_number    | string     | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- has_one :orders



##  orders テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| item_id       | references | null: false, foreign_key: true |
| user_id       | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- has_one :customers
- has_one :items
