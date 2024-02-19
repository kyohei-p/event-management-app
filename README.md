## Railsプロジェクトベース

### 環境構築
- Dockerイメージの構築〜DB作成

```
docker compose build --no-cache
docker compose run web rails db:create
```

- Railsアプリケーションの作成（初回）

```
docker-compose run web rails new .  --force --database=mysql
```

- コンテナの作成と開始

```
docker compose up -d
```

- コンテナに入る（Rails側）

```
docker-compose exec web bash
```

- sorceryの初期設定
```
rails generate sorcery:install
```

- マイグレーション作成&初期データ投入（初回）
```
rails db:migrate && rails db:seed
```

- マイグレーション作成&初期データ投入（2回目以降）
```
rails db:migrate:reset && rails db:seed
```

- Docker再起動

```
docker compose restart
```

#### docker-composeコマンド概要（Tips）

- https://docs.docker.jp/v1.12/compose/reference/overview.html


#### 以下URLにアクセスしサーバーが立ち上がればOK

- http://localhost:3000


### バージョン情報

name|version
--|--
Ruby | 3.2.3
Ruby on Rails | 7.1.3