require "bundler"
Bundler.require

require "./cults_api"
require "meuh/slack_plugin"

module Luc
  class Bot < SlackRubyBot::Bot
    command "latest creation" do |client, data, match|
      client.say(
        channel: data.channel,
        text: CultsAPI.new.latest_creation.fetch("url")
      )
    end

    extend Meuh::SlackPlugin
  end
end

Luc::Bot.run
