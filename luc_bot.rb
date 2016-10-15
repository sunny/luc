require "bundler"
Bundler.require

require "meuh/slack_plugin"

module Luc
  class API
    def latest_creation_url
      http.get("https://cults3d.com/api/v1/creations.json?limit=1")
          .parse
          .first
          .fetch("url")
    end

    private

    attr_reader :user, :pass

    def http
      HTTP.basic_auth(user: ENV.fetch("API_USER"), pass: ENV.fetch("API_PASS"))
    end
  end

  class Bot < SlackRubyBot::Bot
    command 'dernière création' do |client, data, match|
      client.say(channel: data.channel, text: API.new.latest_creation_url)
    end

    extend Meuh::SlackPlugin
  end
end

Luc::Bot.run
