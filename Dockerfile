FROM ruby:3.1.4

WORKDIR /app

RUN apt-get update && \
    apt-get install -y -q curl gnupg2
RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -

RUN apt-get update && \
    apt-get install -y -q nginx

COPY Gemfile Gemfile.lock server.rb /app/
COPY nginx.conf /etc/nginx/sites-available/default
COPY ./server /etc/nginx/ssl/server_certs
COPY ./ca /etc/nginx/ssl/ca_certs

RUN bundle install

CMD ["sh", "-c", "/usr/sbin/nginx; ruby server.rb"]
