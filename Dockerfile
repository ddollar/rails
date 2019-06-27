FROM convox/rails:2.5.0

# copy only the files needed for bundle install
# uncomment the vendor/cache line if you `bundle package` your gems
COPY Gemfile      ./
COPY Gemfile.lock .
# COPY vendor/cache /app/vendor/cache
RUN bundle install

# copy just the files needed for assets:precompile
COPY Rakefile   /app/Rakefile
COPY config     /app/config
COPY public/    .
COPY ./app/assets/ /app/app/assets
RUN rake assets:precompile

RUN nocommand

# copy the rest of the app
COPY . .
