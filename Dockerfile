FROM ruby:2.5.1-stretch

ENV APPLICATION /usr/lib/resources
ENV RAILS_ENV production

WORKDIR /app

COPY app/ app/
COPY bin/ bin/
COPY config/ config/
COPY db/ db/
COPY lib/ lib/
COPY public/ public/
COPY vendor/ vendor/
COPY config.ru config.ru
COPY Rakefile Rakefile
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN wget -q -O /tmp/heroku-buildpack-ruby-master.zip https://github.com/heroku/heroku-buildpack-ruby/archive/master.zip
RUN unzip -q /tmp/heroku-buildpack-ruby-master.zip -d /tmp/
RUN /tmp/heroku-buildpack-ruby-master/bin/detect $APPLICATION && /tmp/heroku-buildpack-ruby-master/bin/compile $APPLICATION/ /tmp
RUN mv -r /app $APPLICATION

WORKDIR $APPLICATION

ENTRYPOINT ["source", "ruby.sh"]

EXPOSE $PORT

CMD ["bin/rails", "server", "--binding", "0.0.0.0"]
