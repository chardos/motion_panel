module Mixpanel
  class EventManager
    include SixtyFour
    include VendorString

    def initialize(token)
      @token = token
    end

    def track(event_name, params = {})
      return false unless config.should_track?
      puts "EVENT JSON: #{event_json(event_name, params)}"
      data = encode_64(event_json(event_name, params))
      url = "http://api.mixpanel.com/track/?data=#{data}"
      AFMotion::JSON.get(url) do |result|
        yield result.body if block_given?
      end
    end

    def people
      people_manager
    end

    private

    def config
      Mixpanel::ConfigManager
    end

    def people_manager
      @people_manager ||= PeopleManager.new(@token)
    end

    def event_json(name, params)
      distinct_id = params.delete('distinct_id') || default_distinct
      hash = {
        'event' => name,
        'properties' => {
          'distinct_id' => distinct_id,
          'token' => @token
        }.merge(params).merge(Mixpanel.default_hash)
      }
      BW::JSON.generate(hash)
    end
  end
end
