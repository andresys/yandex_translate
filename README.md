# yandex_translate.rb
Easy YandexTranslate API for Ruby

**Example:**

```ruby
YandexTranslate.API_KEY = "trnsl.1.1.20160809T124007Z.a9b531dd7173f058.62cd21d34fdfcb33cf9fb2bd3a3d5f1a67336193"

YandexTranslate.get_langs lang # default lang = 'ru'
YandexTranslate.detect text
YandexTranslate.translate text, lang # default lang = 'ru'

# or

puts 'Hello world'.translate
```
