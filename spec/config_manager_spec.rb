describe 'Mixpanel::ConfigManager' do

  class Device
    class << self
      attr_writer :simulator
      def simulator?
        @simulator || false
      end
    end
  end

  class App
    class << self
      attr_writer :development
      def development?
        @development || false
      end

      attr_writer :test
      def test?
        @test || false
      end
    end
  end

  before do
    Mixpanel::ConfigManager.disable_on_simulator = nil
    Mixpanel::ConfigManager.disable_in_development = nil
    Mixpanel::ConfigManager.disable_in_test = nil

    Device.simulator = false
    App.development = false
    App.test = false
  end

  it "should never be disabled on device unless asked" do
    Mixpanel::ConfigManager.should_track?.should == true
  end

  it 'should disable on simulator' do
    Mixpanel::ConfigManager.should_track?.should == true
    Device.simulator = true
    Mixpanel::ConfigManager.disable_on_simulator = true
    Mixpanel::ConfigManager.should_track?.should == false
  end

  it 'should disable in development mode' do
    Mixpanel::ConfigManager.should_track?.should == true
    App.development = true
    Mixpanel::ConfigManager.disable_in_development = true
    Mixpanel::ConfigManager.should_track?.should == false
  end

  it 'should disable in test mode' do
    Mixpanel::ConfigManager.should_track?.should == true
    App.test = true
    Mixpanel::ConfigManager.disable_in_test = true
    Mixpanel::ConfigManager.should_track?.should == false
  end

end
