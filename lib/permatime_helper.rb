begin
  require 'tzinfo'
  TZINFO_AVAILABLE = true
rescue MissingSourceFile
  TZINFO_AVAILABLE = false
end

module PermatimeHelper
  TZINFO_AVAILABLE = TZINFO_AVAILABLE

  def permatime(time=Time.now.utc, options={})
    if time.is_a? Hash
      options = time
      time = Time.now.utc
    end
    timestamp = options[:timestamp]
    timestamp = time if time.is_a? Integer
    if timestamp
      return "http://permatime.com/timestamp/%d" % timestamp
    end
    if options[:title]
      title = "/"+options[:title].gsub(' ','_')
    else
      title =''
    end
    display_time = options[:time]
    timezone = options[:timezone]
    if timezone && display_time.nil?
      if TZINFO_AVAILABLE
        display_time = TZInfo::Timezone.get(timezone).utc_to_local(time.utc)
      else
        warn "PermatimeHelper can't set timezone when tzinfo gem not available"     
        timezone = nil
      end
    end
    timezone ||= 'UTC'
    display_time ||= time
    year = options[:year] || display_time.year
    month = options[:month] || display_time.month
    day = options[:day] || display_time.day
    hour = options[:hour] || display_time.hour
    min = options[:min] || display_time.min
    "http://permatime.com/%s/%04d-%02d-%02d/%02d:%02d%s" % [
    timezone, year, month, day, hour, min, title
    ] 
  end
  
  
end
