LucBot
======

A Slack bot that has a command to get data from [Cults](https://cults3d.com)
and includes [Meuh](github.com/sunny/meuh).

Commands
--------

- `@luc latest creation` prints the URL to the last Cults creation

Install
-------

[Register a Slack bot](http://slack.com/services/new/bot), clone this
repository, and:

```sh
$ bundle install
$ export CULTS_API_USER=…
$ export CULTS_API_PASS=…
$ export SLACK_API_TOKEN=…
$ ruby slack_bot.rb
```
