######################
# Stage: Builder
FROM ruby:2.5.1-alpine3.7 as Builder

RUN apk add --update --no-cache \
    build-base \
    mysql \
    mysql-client \
    mariadb-dev \
    git \
    nodejs-current \
    yarn

WORKDIR /app

# Install gems
ADD Gemfile* /app/
RUN bundle config --global frozen 1 \
 && bundle install --without development test -j4 --retry 3 \
 # Remove unneeded files (cached *.gem, *.o, *.c)
 && rm -rf /usr/local/bundle/cache/*.gem \
 && find /usr/local/bundle/gems/ -name "*.c" -delete \
 && find /usr/local/bundle/gems/ -name "*.o" -delete

# Install yarn packages
# COPY package.json yarn.lock /app/
# RUN yarn install


# Precompile assets
# RUN RAILS_ENV=production SECRET_KEY_BASE=foo bundle exec rake assets:precompile

# Remove folders not needed in resulting image
# RUN rm -rf tmp/cache app/assets vendor/assets lib/assets spec

###############################
# Stage Final
FROM ruby:2.5.1-alpine3.7

# Add Alpine packages
RUN apk add --update --no-cache \
    mysql-dev \
    tzdata \
    file \
    curl

# Copy app with gems from former build stage
COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/

ADD . /app

# Set Rails env
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true
ENV EXECJS_RUNTIME Disabled

WORKDIR /app

# Expose Puma port
EXPOSE 3000

# Save timestamp of image building
RUN date -u > BUILD_TIME

# Start up

ENV RAILS_ENV staging
ENV SECRET_KEY_BASE=hoge

CMD ["rails", "s"]
