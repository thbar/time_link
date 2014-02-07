require "time_link/version"

module TimeLink
  extend self

  def build(time, format = '6bj')
    # for now, I only support Time here
    raise ArgumentError unless time.is_a?(Time)

    # offset seems to be computed in minutes and relative to 12PM UTC
    lunch_time_utc = Time.new(time.year, time.month, time.day, 12, 0, 0, '+00:00')
    offset = (time - lunch_time_utc) / 60
    
    "http://everytimezone.com/#%d-%d-%d,%d,%s" % [time.year, time.month, time.day, offset, format]
  end
end
