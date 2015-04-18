class Mixpanel
  @@mixpanel_token = nil
  @@event_manager = nil
  class << self
    def shared_instance_with_token(token)
      fail Mixpanel::InvalidTokenError unless token.length > 5
      @@mixpanel_token = token
      event_manager
    end

    def shared_instance
      fail Mixpanel::NoTokenError unless @@mixpanel_token
      event_manager
    end

    private

    def event_manager
      @@event_manager ||= Mixpanel::EventManager.new(mixpanel_token)
    end

    def self.mixpanel_token
      @@mixpanel_token
    end
  end
end