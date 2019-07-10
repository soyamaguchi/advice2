FROM ruby:2.6.3

# 必要なライブラリをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client cron

# yarnパッケージ管理ツールをインストール
RUN apt-get update -qq && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs

ENV APP_DIR /advice2
# Rails App
RUN mkdir /advice2
WORKDIR $APP_DIR
ADD Gemfile $APP_DIR
ADD Gemfile.lock $APP_DIR
RUN bundle install
ADD . $APP_DIR

# wheneverでcrontabの更新
RUN bundle exec whenever --update-crontab
# cronをフォアグラウンド実行
CMD ["cron", "-f"]
