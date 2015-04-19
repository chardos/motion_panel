module Mixpanel
  module SixtyFour
    def encode_64(json)
      CGI.escape([json].pack('m'))
    end
  end
end
