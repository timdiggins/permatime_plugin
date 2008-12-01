require "#{File.dirname(__FILE__)}/test_helper"
require "#{File.dirname(__FILE__)}/../lib/permatime_helper"


class PermatimeHelperTest < ActiveSupport::TestCase
  include PermatimeHelper
  should "work with no params" do
    p = permatime
    t = Time.now.utc
    assert_equal 'http://permatime.com/%s/%04d-%02d-%02d/%02d:%02d' %["GMT", t.year, t.month, t.day, t.hour, t.min], p
  end
  
  should "work with title set" do
    p = permatime :title=>'My lovely title'
    t = Time.now.utc
    assert_equal 'http://permatime.com/%s/%04d-%02d-%02d/%02d:%02d/My_lovely_title' %["GMT", t.year, t.month, t.day, t.hour, t.min], p
  end
  
  should "work with timezone only set" do
    p = permatime :timezone=>'US/Pacific'
    t = TZInfo::Timezone.get(expected_timezone).utc_to_local Time.now.utc
    assert_equal 'http://permatime.com/%s/%04d-%02d-%02d/%02d:%02d' %[expected_timezone,t.year, t.month, t.day, t.hour, t.min], p
  end
  
  should "work with time set" do
    t = Time.now    
    p = permatime :timezone=>'US/Pacific', :time=>t
    assert_equal 'http://permatime.com/US/Pacific/%04d-%02d-%02d/%02d:%02d' %[t.year, t.month, t.day, t.hour, t.min], p
  end
  
  should "work with timestamp 1" do
    p = permatime :timestamp=>123456
    assert_equal 'http://permatime.com/timestamp/123456' , p
  end
  
  should "work with timestamp 2" do
    p = permatime 123456
    assert_equal 'http://permatime.com/timestamp/123456' , p
  end
  
  should "work with everything set" do
    p = permatime :year=>2008, :month=>10, :day=>13, :hour=>10, :min=>23, :timezone=>'US/Pacific', :title=>'My lovely title'
    assert_equal 'http://permatime.com/%s/2008-10-13/10:23/My_lovely_title' % expected_timezone, p
  end  
  
  def expected_timezone
    if PermatimeHelper::TZINFO_AVAILABLE
      'US/Pacific'
    else
      'GMT'
    end
  end
end
