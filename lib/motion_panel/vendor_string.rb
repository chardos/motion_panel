module Mixpanel
  module VendorString
    def default_distinct
      Device.vendor_identifier.UUIDString
    end
  end
end
