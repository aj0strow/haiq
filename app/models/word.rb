require 'redis'
require 'curb'
require 'nokogiri'

class Word < String
  def self.redis
    @redis ||= Redis.new(url: ENV['REDISCLOUD_URL'])
  end

  def redis
    self.class.redis
  end

  def syllables
    amount = redis.get(to_s)
    if amount == ''
      amount = scrape_syllables_count
      redis.set(to_s, amount)
    end
    amount = amount.to_i
    raise ArgumentError.new(self) if amount <= 0
    amount.to_i
  end

  def scrape_syllables_count
    response = Curl.get('http://www.howmanysyllables.com/words/' + to_s)
    page = Nokogiri::HTML(response.body_str)
    matches = page.css('#SyllableContainer_ResultFormatting')
    matches.any? ? matches.first.text.to_i : 0
  end
end
