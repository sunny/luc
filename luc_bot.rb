require "bundler"
Bundler.require

require "./cults_api"
require "meuh/slack_plugin"

module Luc
  class Bot < SlackRubyBot::Bot
    command "latest creation" do |client, data, match|
      creation = CultsAPI.new.latest_creation
      creator = creation["creator"]
      client.say(
        channel: data.channel,
        text: "The latest creation is *#{creation["name"]}* " \
              "by *#{creator["nick"]}*: #{creation["url"]} :new:"
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

    command "most liked creation" do |client, data, match|
      creation = CultsAPI.new.most_liked_creation
      creator = creation["creator"]
      client.say(
        channel: data.channel,
        text: "The most liked creation is *#{creation["name"]}* " \
              "by *#{creator["nick"]}*: #{creation["url"]} :heart:"
      )
    end

    extend Meuh::SlackPlugin
  end
end

Luc::Bot.run
