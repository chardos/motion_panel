module Mixpanel
  class EventManager
    include SixtyFour

    def initialize(token)
      @token = token
    end

    def track(event_name, params = {})
      return false unless config.should_track?
      data = encode_64(event_json(event_name, params))
      url = "http://api.mixpanel.com/track/?data=#{data}"
      AFMotion::JSON.get(url) do |result|
        yield result.body if block_given?
      end
    end

    def people
      people_manager
    end

    def set_person(distinct_id, params = {})
      puts '## Set person is depreciated, please use people.set'
      return false unless config.should_track?
      people_manager.set(distinct_id, params)
    end

    private

    def config
      Mixpanel::ConfigManager
    end

    def people_manager
      @people_manager ||= PeopleManager.new(@token)
    end

    def event_json(name, params)
      hash = {
        'event' => name,
        'properties' => {
          'token' => @token
        }.merge(params).merge(Mixpanel.default_hash)
      }
      BW::JSON.generate(hash)
    end
  end
end
