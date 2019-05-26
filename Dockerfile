FROM ruby:2.6.3

# 必要なモジュールをインストール
# ここでpostgresのクライアントを入れておく
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs postgresql-client
RUN apt-get install -y cron

ENV APP_DIR /advice2

# Rails App
RUN mkdir /advice2
WORKDIR $APP_DIR
ADD Gemfile $APP_DIR
ADD Gemfile.lock $APP_DIR
RUN bundle install
ADD . $APP_DIR
RUN mkdir -p tmp/sockets # nginxとの通信用

# wheneverでcrontabの更新
RUN bundle exec whenever --update-crontab
# cronをフォアグラウンド実行
CMD ["cron", "-f"]

# Expose volumes to frontend
VOLUME /advice2/public
VOLUME /advice2/tmp

# Start Server
CMD bundle exec puma

