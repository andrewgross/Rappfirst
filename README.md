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

All contact with the API starts with connecting via the Client.
```ruby
include 'rappfirst'
c = Rappfirst::Client.new(username="user@example.com", api_key="1234567890")
```

Get an array of Server Objects
```ruby
servers = c.servers
```

Or query for a single server by hostname
```ruby
my_server = c.servers(query_string="?hostname=my-server")
```

If you know the id, you can just get the server object directly
```ruby
my_first_server = c.server('1')
```

Once you have a Server Object, it's attributes are immediately accessible
```ruby
my_server.id
my_server.architecture
my_server.hostname
...
```

The attributes are a Server Object are read only, except for `nickname` and `description`
```ruby
my_server.id = 2 # Fails

my_server.description = "Just an example server"
# Setting these back on the server is not implemented yet as of 0.1.0
```

Grab some outage info
```ruby
my_server.outages
```

Refresh your outage info
```ruby
my_server.outages(refresh=true)
```

Check out the tags
```ruby
my_server.tags
my_server.tags(refresh=true)
```

Set some new tags
```ruby
my_server.tags = ["Prod", "Web"]
# Setting these back on the server is not implemented yet as of 0.1.0
```

Get your `polled_data_config`. We can't set the polled data config yet due to some API issues. =(
```ruby
my_server.polled_data_config
```

Delete your server.  This will send the API call, but currently does not modify your local copy of the object.
```ruby
my_server.delete
```

All information should be cached locally after the first request or object creation.
```ruby
# Cached on creation
my_server.id
my_server.hostname
my_server.architecture
...

# Cached on method call
my_server.outages
my_server.polled_data_config
my_server.tags
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

NOTE: Since I haven't had a chance to create a 'clean' set of fixtures, I have not committed the fixture data.  Therefore tests will reference server id's and hostnames that will not exist in your environment.  You will need to fix these to get the tests passing.  I should have a set of clean fixtures added soon.
