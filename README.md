# Rappfirst

A ruby wrapper for the Appfirst API v3.  Currently implementing the `/servers/` endpoint.  As this is still in beta several parameters are not fully implemented.

**Implemented**
* `/servers/`
* `/servers/{id}`
* `/servers/{id}/tags`
* `/servers/{id}/polled_data_config`
* `/servers/{id}/outages`

**TODO**
* `/servers/{id}/data`
* `/servers/{id}/processes`
* `/servers/{id}/auto_detection`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rappfirst'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install rappfirst
```

## Usage

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
