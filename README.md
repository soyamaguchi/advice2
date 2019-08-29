# Advice2
知っておいて損はないお得な自治体情報サイト

## :blue_book: Description
 - 地方自治体のお得な行政サービスのみを掲載
 - 様々な行政サービスが存在する中、あまり周知されていないがために、知らないことで損をしないよう情報を得ることをコンセプトとしている

***DEMO:***

![Demo](https://raw.githubusercontent.com/wiki/soyamaguchi/advice2/imgs/advice2.gif)

## :dizzy: Features
 - 作成したCrawlerで自治体サイトをスクレイピング
 - スクレイピング時に前回スクレイピング時のデータと比較して更新があった場合や新規データの場合は管理者に知らせて管理者がお得だと判断したもののみ登録され、掲載される(対応予定)

## :hammer: Tech Stack
  ### Development
  - Docker 19.03.1
  - Docker Compose 1.24.1
  ### Production
  - AWS
    - EC2 (webserver:nginx-1.17.3, appserver:unicorn-5.5.1, db:PostgreSQL-9.2.24)
    - SSL (ELB:ALB, Route53, ACM)
  ### CI
  - CircleCI
  ### Deploy
  - capistrano
  ### Crawler & Batch
  - mechanize
  - whenever
  ### Backend, Frontend
  - Ruby 2.6.3
  - Rails 5.2.3
  - RSpec 3.8
  - Node.js 12.7.0
  - Yarn 1.17.3
  - Webpacker 4.0.7
  - Vue.js 2.6.10
  - Vuex 3.1.1
  - Semantic UI

## :pushpin: Installation

```console
$ mkdir workspace
$ cd workspace
$ git clone git@github.com:soyamaguchi/advice2.git
$ docker-compose up --build
```

## :exclamation: Cautions
 - データは存在しないためコンテンツは表示されません

## :squirrel: Author

[@\_soyamaguchi_](https://twitter.com/_soyamaguchi_)

## :bookmark: License

[MIT](https://github.com/soyamaguchi/advice2/blob/master/LICENSE)
