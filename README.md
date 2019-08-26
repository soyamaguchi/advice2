# Advice2

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# Tech Stack
  ## Development
  - Docker 19.03.1
  - Docker Compose 1.24.1
  ## Production
  - AWS
    - EC2 (webserver:nginx-1.17.3, appserver:unicorn-5.5.1, db:PostgreSQL-9.2.24)
    - SSL (ELB:ALB, Route53, ACM)
  ## CI
  - CircleCI
  ## Deploy
  - capistrano
  ## Crawler & Batch
  - mechanize
  - whenever
  ## Backend, Frontend
  - Ruby 2.6.3
  - Rails 5.2.3
  - RSpec 3.8
  - Node.js 12.7.0
  - Yarn 1.17.3
  - Webpacker 4.0.7
  - Vue.js 2.6.10
  - Vuex 3.1.1
  - Semantic UI
