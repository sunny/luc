module Luc
  class CultsAPI
    def latest_creation
      http.get("http://cults3d.com/api/v1/creations.json?limit=1")
          .parse
          .first
    end

    def most_downloaded_creation
      http.get("http://cults3d.com/api/v1/creations.json?limit=1&sort=sales_counter")
          .parse
          .first
    end

    def most_liked_creation
      http.get("http://cults3d.com/api/v1/creations.json?limit=1&sort=likes_counter")
          .parse
          .first
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
