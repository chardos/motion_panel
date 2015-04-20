module Mixpanel
  class PeopleManager
    include SixtyFour

    attr_accessor :token

    def initialize(token)
      self.token = token
    end

    def set(params = {})
      distinct_id = params.delete('distinct_id') || default_distinct
      engage_action(distinct_id, params, '$set', true)
    end

    def set_once(params = {})
      distinct_id = params.delete('distinct_id') || default_distinct
      engage_action(distinct_id, params, '$set_once', false)
    end

    def add(params = {})
      distinct_id = params.delete('distinct_id') || default_distinct
      engage_action(distinct_id, params, '$add', false)
    end

    def append(params = {})
      distinct_id = params.delete('distinct_id') || default_distinct
      engage_action(distinct_id, params, '$append', false)
    end

    # def unset(params = {})
    #   distinct_id = params.delete('distinct_id') || default_distinct
    #   engage_action(distinct_id, params, '$unset', false)
    # end

    def delete!(params = {})
      distinct_id = params.delete('distinct_id') || default_distinct
      engage_action(distinct_id, {}, '$delete', false)
    end

    private

    def default_distinct
      Device.vendor_identifier.UUIDString
    end

    def engage_action(distinct_id, params, action, add_default_hash)
      return false unless config.should_track?
      data = encode_64(person_json(distinct_id, params, action, add_default_hash))
      url = "http://api.mixpanel.com/engage/?data=#{data}"
      AFMotion::JSON.get(url) do |result|
        yield result.body if block_given?
      end
    end

    def config
      Mixpanel::ConfigManager
    end

    def person_json(distinct_id, params, action, add_default_hash)
      hash = {
        '$token' => token,
        '$distinct_id' => distinct_id,
        action => add_default_hash ? params.merge(Mixpanel.default_hash) : params
      }
      BW::JSON.generate(hash)
    end
  end
end
