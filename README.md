# README



## For development
This app uses redis and sidekiq for processing background tasks. To run this you need to have installed redis server. You can download it [here](https://redis.io/download).

You need to run the following commands before executing rails server

```
$ cd redis-3.2.8
$ src/redis-server
$ bundle exec sidekiq
```
