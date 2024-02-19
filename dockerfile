FROM ruby:3.2.3

WORKDIR /event-management-app

COPY Gemfile Gemfile.lock /event-management-app/

RUN gem update --system \
    && bundle update --bundler \
    && bundle install

COPY . /event-management-app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
