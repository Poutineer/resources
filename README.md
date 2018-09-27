## Todo

  - Francises
  - highlight ask for password
  - Turn rails console access into gem

## Notes

### Making a new resource

  0. Create a route in `config/routes.rb`
  0. Create a controller in `app/controllers/{version}/{plural(name)}_controller.rb`
  0. Create a policy in `app/policies/{version}/{name}_policy.rb`
  0. Create a instance decorator in `app/decorators/{name}_decorator.rb`
  0. Create a collection decorator in `app/decorators/{plural(name)}_decorator.rb`
  0. Create a realizer in `app/realizers/{version}/{name}_realizer.rb`
  0. For each action allowed create a schema: `app/schemas/{version}/{plural(name)}/{action}_schema.rb`
  0. Create a serializer in `app/serializers/{version}/{name}_serializer.rb`

## Setup

  0. `heroku addons:create heroku-redis:hobby-dev --app={application} --maxmemory_policy=noeviction --as=REDIS_SIDEKIQ`
  0. `heroku addons:create heroku-redis:hobby-dev --app={application} --maxmemory_policy=noeviction --as=REDIS_OBJECTS`
  0. `heroku addons:create heroku-redis:hobby-dev --app={application} --maxmemory_policy=volatile-lru --as=REDIS_CACHE`
  0. `heroku addons:create heroku-redis:hobby-dev --app={application} --maxmemory_policy=noeviction --as=REDIS_REDLOCK`
  0. `heroku addons:create heroku-redis:hobby-dev --app={application} --maxmemory_policy=noeviction --as=REDIS_ACTION_CABLE`
