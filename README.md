## Nap Time

Nap Time is a generic REST API client.

## Installation

## Usage

### As A Gem

### With IRB

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

+ Start irb
+ load 'rest_client.rb'
+ t = RestClient.new

## Contact
+ Andrew Fong (fong.andrew.j@gmail.com)
