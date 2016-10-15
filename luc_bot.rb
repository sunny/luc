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

    command "most downloaded creation" do |client, data, match|
      creation = CultsAPI.new.most_downloaded_creation
      creator = creation["creator"]
      client.say(
        channel: data.channel,
        text: "The most downloaded creation is *#{creation["name"]}* " \
              "by *#{creator["nick"]}*: #{creation["url"]} :champagne:"
      )
    end

    extend Meuh::SlackPlugin
  end
end

Luc::Bot.run
