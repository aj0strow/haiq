require 'redis'
require 'curb'
require 'nokogiri'
require 'active_support/core_ext'

class Word < String
  def self.redis
    @redis ||= Redis.new(url: ENV['REDISCLOUD_URL'])
  end

  def redis
    self.class.redis
  end

  def redis_key
    to_s
  end

  def redis_get
    redis.get(redis_key).presence.try(:to_i)
  end

  def redis_set(value)
    redis.set(redis_key, value)
    redis.expire(redis_key, 60 * 60 * 24) if value <= 0
    value
  end

  def syllables
    (redis_get || redis_set(scrape_syllables_count)).tap do |value|
      raise ArgumentError.new(self) if value <= 0
    end
  end

  def scrape_syllables_count
    response = Curl.get('http://www.howmanysyllables.com/words/' + to_s)
    page = Nokogiri::HTML(response.body_str)
    matches = page.css('#SyllableContainer_ResultFormatting')
    matches.any? ? matches.first.text.to_i : 0
  end
end
