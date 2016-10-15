require "bundler"
Bundler.require

require "./cults_api"
require "meuh/slack_plugin"

module Luc
  class Bot < SlackRubyBot::Bot
    command "help" do |client, data, match|
      client.say(
        channel: data.channel,
        text: [
          "Commands:",
          "*@luc <num> latest creations* - Latest creations on Cults",
          "*@luc <num> most liked creations* - Most liked creations on Cults",
          "*@luc <num> most downloaded creations* - Most downloaded creations on Cults",
        ]
      )
    end

    command "latest creation" do |client, data, match|
      client.typing(channel: data.channel)
      creation = CultsAPI.new.latest_creation
      creator = creation["creator"]
      client.say(
        channel: data.channel,
        text: ":new: The latest creation on :cults: is *#{creation["name"]}* " \
              "by *#{creator["nick"]}*: #{creation["url"]}"
      )
    end

    match(/(?<bot>[[:alnum:][:punct:]@<>]*)\s(?<count>\d+) latest creations$/) do |client, data, match|
      client.typing(channel: data.channel)
      count = match["count"].to_i
      creations = CultsAPI.new.latest_creations(limit: count)
      client.say(
        channel: data.channel,
        text: [":new: The #{count} latest creations on :cults: are:",
               creations.map { |creation| "- #{creation["url"]}" }].compact,
        giphy: "yay"
      )
    end

    command "most downloaded creation" do |client, data, match|
      client.typing(channel: data.channel)
      creation = CultsAPI.new.most_downloaded_creation
      creator = creation["creator"]
      client.say(
        channel: data.channel,
        text: ":champagne: The most downloaded creation on :cults: is " \
              "*#{creation["name"]}* by *#{creator["nick"]}*: " \
              "#{creation["url"]}"
      )
    end

    match(/^(?<bot>[[:alnum:][:punct:]@<>]*)\s(?<count>\d+) most downloaded creations$/) do |client, data, match|
      client.typing(channel: data.channel)
      count = match["count"].to_i
      creations = CultsAPI.new.most_downloaded_creations(limit: count)
      client.say(
        channel: data.channel,
        text: [":champagne: The #{count} most downloaded creations on :cults: are:",
               creations.map { |creation| "- #{creation["url"]}" }].compact,
        gif: "download"
      )
    end

    command "most liked creation" do |client, data, match|
      client.typing(channel: data.channel)
      creation = CultsAPI.new.most_liked_creation
      creator = creation["creator"]
      client.say(
        channel: data.channel,
        text: ":heart: The most liked creation on :cults: is *#{creation["name"]}* " \
              "by *#{creator["nick"]}*: #{creation["url"]}"
      )
    end

    match(/^(?<bot>[[:alnum:][:punct:]@<>]*)\s(?<count>\d+) most liked creations$/) do |client, data, match|
      client.typing(channel: data.channel)
      count = match["count"].to_i
      creations = CultsAPI.new.most_liked_creations(limit: count)
      client.say(
        channel: data.channel,
        text: [":heart: The #{count} most liked creations on :cults: are:",
               creations.map { |creation| "- #{creation["url"]}" }].compact,
        giphy: "like"
      )
    end


    extend Meuh::SlackPlugin
  end
end

Luc::Bot.run
