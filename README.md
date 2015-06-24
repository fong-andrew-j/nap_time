## Nap Time

Nap Time is a generic REST API client.

## Installation

## Configuration File Format

The configuration file should be a .yml file. The yaml keys should be symbols.
It should be of the format
 
   :service:
      :base_url:
        :api_version
          :endpoints

The endpoints can include <sub> which stand in place of values that can be 
overwritten in method calls. If no substitution values are provided, these <sub>
strings will be removed.

    :jsonplaceholder:
      :base: 'http://jsonplaceholder.typicode.com'
      :v1:
        :posts: '/posts/<sub>/<sub>'
        :comments: '/comments'
        :albums: '/albums'
        :photos: '/photos'
        :todos: '/todos'
        :users: '/users'

## Usage

### As A Gem

### With IRB

+ Start irb
+ load 'lib/rest_client.rb'
+ t = RestClient.new
+ t.get(endpoint: :posts) # simple get off an endpoints
+ t.get(endpoint: :posts, subs: [1, 'comments']) # get with url substitutions
+ t.get(endpoint: :posts, parameters: {a: 1} # get with url parameters, results 
                                             # in ?a=1 appended to url

## Contact
+ Andrew Fong (fong.andrew.j@gmail.com)
