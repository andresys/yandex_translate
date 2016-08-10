# yandex_translate.rb
# Название говорит само за себя, при использовании в продакшене не забываем про
# условия использования API Переводчика от Yandex https://yandex.ru/legal/translate_api/,
# а так же не забываем про YandexTranslate.API_KEY
# author: Mikhail Kudryavtsev, email: mihail.kudryavcev@gmail.com, modified: 09.08.2016

require 'net/http'
require 'json'

class YandexTranslate
  class << self
    attr_accessor :API_KEY
  end

  def self.get_langs(ui = 'ru')
    res = http_request 'getLangs', {:ui => ui}
    [401, 402].include?(res['code']) ? res : (res || {:langs => {}})['langs']
  end

  def self.detect(text = '')
    res = http_request('detect', {:text => text})
    [401, 402, 404].include?(res['code']) ? res : res['lang']
  end

  def self.translate(text = '', lang = 'ru')
    res = http_request('translate', {:text => text, :lang => lang})
    [401, 402, 404, 413, 422, 501].include?(res['code']) ? res : res['text']
  end

private
  
  def self.http_request(command, params)
    uri = URI("https://translate.yandex.net/api/v1.5/tr.json/#{command}")
    uri.query = URI.encode_www_form({:key => self.API_KEY}.merge(params))

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    res = http.get(uri.request_uri)
    JSON.parse(res.body) #if res.is_a?(Net::HTTPSuccess)
  end
end

class String
  def translate(lang = 'ru')
    YandexTranslate.translate self, lang
  end
end
