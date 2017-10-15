# Scrabble Checker

### What's it do?
Well, as the name might indicate, this app verifies words that one might make using tiles in Scrabble. But! It also allows the user to enter in a list of their tiles to get a list of possible words they can work with.

### How's it do it?
Rails
Faraday

### Set it up!
Go ahead and bundle, like a boss. Part of what should be included is Figaro.
Run `bundle exec Figaro install`

You'll need a couple environment variables in your application.yml:
```ruby
oxford_dictionary_app_id:
oxford_dictionary_app_key:
```

Go on down to https://developer.oxforddictionaries.com/ and sign up for an account.
