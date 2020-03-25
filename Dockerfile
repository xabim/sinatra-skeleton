FROM ruby:2.7.0-alpine3.11 as base

ENV APP /app
WORKDIR $APP

COPY Gemfile $APP
COPY Gemfile.lock $APP

FROM base as test
RUN apk update \
  && apk add --virtual \
  build_deps \
  build-base \
  g++ \
  linux-headers \
  sqlite-dev
RUN bundle config set without 'production' \
  && bundle install --quiet -j 10 \
  && apk del build_deps \
  && apk --update add sqlite sqlite-libs

COPY . $APP
CMD ["bundle", "exec", "thin", "start"]


FROM base as release
RUN apk update \
  && apk add --virtual \
  build_deps \
  build-base \
  g++ \
  linux-headers \
  postgresql-dev
RUN bundle config set without 'development test' \
  && bundle install --quiet -j 10 \
  && apk del build_deps sqlite sqlite-libs \
  && apk --update add libpq

COPY . $APP
COPY docker-entrypoint.sh /usr/local/app/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/app/docker-entrypoint.sh"]
CMD ["bundle", "exec", "thin", "start"]

EXPOSE 3000/tcp
