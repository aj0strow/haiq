# HaiQ

I didn't think of the idea, just had time to kill during layovers. http://hiq575.herokuapp.com/

### Install

You need Ruby and Postgres. Install with rbenv and homebrew respectively. Once the database is running, create a user for the application. 

```
$ psql postgres -c 'create role haiq login createdb;'
```

Install gems, run migrations. 

```
$ gem install
$ rake db:migrate
```

Finally, I've excluded the `env.sh` file which exports the `TWITTER_KEY`, `TWITTER_SECRET`, and `SECRET` environment variables. Prolly want to create a file and source it into the shell.

Run the tests, and consider adding an alias to `rspec` in your profile to save typing. 

```
$ RACK_ENV=test bundle exec rspec
```

### Schema

Users

```
id  (pk, auto-incrementing)
twitter_id  (string, not null, indexed)
name  (string, not null)
image  (string, not null)
created_at  (time)
updated_at  (time)
```

Haikus

```
id  (pk, auto-incrementing)
user_id  (fk, indexed)
first  (string, not null)
second  (string, not null)
third  (string, not null)
created_at  (time)
updated_at  (time)
```

Syllable counts are cached using redis, without a prefix. The data comes from scraping howmanysyllables.com. 

### Notes

I chose nearly every piece of the stack to get familiar with a new framework. First time finishing a project with Sinatra, Sequel, and Angular. 

Postgres works with Heroku, and ERB doesn't conflict with Angular's brace syntax. Bower and Omniauth make life easier. 

The client app needs a lot of improvement, starting with tests. As far as caching, syllable counts should be saved to local storage, and the assets should be minified and fingerprinted. 

License: **MIT** 
