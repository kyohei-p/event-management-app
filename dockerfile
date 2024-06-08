FROM ruby:3.2.3

WORKDIR /event-management-app

COPY Gemfile Gemfile.lock /event-management-app/

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && apt-get install -y nodejs

RUN gem update --system
RUN bundle update --bundler
RUN bundle install
RUN rm -rf /usr/local/bundle/cache
RUN curl https://cli-assets.heroku.com/install.sh | sh

COPY . /event-management-app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
