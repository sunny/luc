module Luc
  class CultsAPI
    def latest_creation
      http.get("https://cults3d.com/api/v1/creations.json?limit=1")
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