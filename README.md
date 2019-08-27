# Advice2
知っておいて損はないお得な自治体情報サイト。

## :blue_book: Description
 - 地方自治体のお得な行政サービスのみを掲載。
 - 様々な行政サービスが存在する中、あまり周知されていないがために、知らないことで損をしないよう情報を得ることをコンセプトとしている。

## Tech Stack
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
