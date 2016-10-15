module Luc
  class CultsAPI
    def latest_creation
      latest_creations(limit: 1).first
    end

    def most_downloaded_creation
      most_downloaded_creations(limit: 1).first
    end

    def most_liked_creation
      most_liked_creations(limit: 1).first
    end

    def latest_creations(limit:)
      http.get("http://cults3d.com/api/v1/creations.json?limit=#{limit}")
          .parse
    end

    def most_downloaded_creations(limit:)
      http.get("http://cults3d.com/api/v1/creations.json?limit=#{limit}&sort=sales_counter")
          .parse
    end

    def most_liked_creations(limit:)
      http.get("http://cults3d.com/api/v1/creations.json?limit=#{limit}&sort=likes_counter")
          .parse
    end


    private

    attr_reader :user, :pass

    def http
      HTTP.basic_auth(
        user: ENV.fetch("CULTS_API_USER"),
        pass: ENV.fetch("CULTS_API_PASS")
      )
    end
  end
end
