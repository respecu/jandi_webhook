require 'fastlane/action'
require_relative '../helper/jandi_webhook_helper'
require 'json'
require 'httparty'

module Fastlane
  module Actions
    class JandiWebhookAction < Action
      def self.run(params)
        UI.message("The jandi_webhook plugin is working!")

        headers = { 
          "Content-Type"  => "application/json",
          "Accept" => "application/vnd.tosslab.jandi-v2+json" 
        }

        message = {
          body: "#{params[:appName]} 테스트 앱이 배포되었습니다.\n#{params[:link]}",
          connectColor: "#ea002c",
          connectInfo: [
            {
            title: "#{params[:deployService]}를 확인해 주세요.",
            description: "#{params[:version]} for #{params[:platform]}"
            }
          ]
        }

        UI.message(message.to_json)
        UI.message("#{params[:jandi_url]} for #{params[:platform]} ")

        #Send the request
        response = HTTParty.post(params[:jandi_url], :headers => headers, body: message.to_json)
        UI.message("response : #{response}")
      end

      def self.description
        "webhook for jandi"
      end

      def self.authors
        ["respecu"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "webhook for jandi after action"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :jandi_url,
                                  env_name: "JANDI_WEBHOOK_URL",
                               description: "webhook url for jandi",
                                  optional: false,
                                      type: String),

          FastlaneCore::ConfigItem.new(key: :platform,
                                  env_name: "DEPLOYMENT_PLATFORM",
                                description: "platform android or ios",
                                  optional: false,
                                      type: String),
          
          FastlaneCore::ConfigItem.new(key: :version,
                                  env_name: "DEPLOYMENT_VERSION",
                                description: "app version",
                                  optional: false,
                                      type: String),

          FastlaneCore::ConfigItem.new(key: :appName,
                                  env_name: "APP_NAME",
                                description: "app name",
                                  optional: false,
                                      type: String),

          FastlaneCore::ConfigItem.new(key: :link,
                                  env_name: "LINK",
                                description: "link",
                                  optional: true,
                                      type: String)
          
          FastlaneCore::ConfigItem.new(key: :deployService,
                                  env_name: "deployService",
                                description: "deployService",
                                  optional: true,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
