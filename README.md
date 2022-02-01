# テーブル設計

## users テーブル

| Column                | Type      | Options     |
| --------------------- | --------- | ----------- |
| nickname              | string    | null: false |
| email                 | string    | null: false |
| encrypted_password    | string    | null: false |
| password_confirmation | string    | null: false |
| first_name            | string    | null: false |
| family_name           | string    | null: false |
| date_of_birth         | datetime  | null: false |



### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column            | Type        | Options                        |
| ----------------- | ----------- | ------------------------------ |
| name              | string      | null: false                    |
| category          | string      | null: false                    |
| price             | integer     | null: false                    |
| content           | text        | null: false                    |
| condition         | string      | null: false                    |
| user              | references  | null: false, foreign_key: true |
| purchase          | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :shipping

## shippings テーブル

| Column                   | Type        | Options                        |
| ------------------------ | ----------- | ------------------------------ |
| post_code                | integer     | null: false                    |
| prefecture               | string      | null: false                    |
| municipality             | string      | null: false                    |
| address                  | string      | null: false                    |
| building_name            | string      | null: false                    |
| phone_number             | integer     | null: false                    |
| purchase                 | references  | null: false, foreign_key: true |


### Association

- belongs_to :purchase