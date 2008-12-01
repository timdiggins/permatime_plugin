require "#{File.dirname(__FILE__)}/test_helper"
require "#{File.dirname(__FILE__)}/../lib/permatime_helper"
require "#{File.dirname(__FILE__)}/../lib/permatime_time_monkeypatcher"


Time.send :include, PermatimeTimeMonkeypatcher

class PermatimeMonkeypatchTest < ActiveSupport::TestCase
  should "work with no params" do
    p = Time.now.permatime
    t = Time.now.utc
    assert_equal 'http://permatime.com/%s/%04d-%02d-%02d/%02d:%02d' %["GMT", t.year, t.month, t.day, t.hour, t.min], p
  end
  
  should "work with title set" do
    p = Time.now.permatime :title=>'My lovely title'
    t = Time.now.utc
    assert_equal 'http://permatime.com/%s/%04d-%02d-%02d/%02d:%02d/My_lovely_title' %["GMT", t.year, t.month, t.day, t.hour, t.min], p
  end
  
  should "work with timezone only set" do
    p = Time.now.permatime :timezone=>'US/Pacific'
    t = TZInfo::Timezone.get(expected_timezone).utc_to_local Time.now.utc
    assert_equal 'http://permatime.com/%s/%04d-%02d-%02d/%02d:%02d' %[expected_timezone,t.year, t.month, t.day, t.hour, t.min], p
  end
  
  def expected_timezone
    if PermatimeHelper::TZINFO_AVAILABLE
      'US/Pacific'
    else
      'GMT'
    end
  end
end
