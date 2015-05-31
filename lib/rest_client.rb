require 'yaml'
require 'httparty'

class RestClient
  attr_reader :config, :service, :base_url, :version, :endpoints
  def initialize(args={})
    @config = args[:config].nil? ? YAML.load_file('../config/url_config.yml') : YAML.load_file(args[:config])
    @service = :jsonplaceholder #args[:service]
    @base_url = config[service][:base]
    @version = args[:version].nil? ? :v1 : args[:version]
    @endpoints = config[service][version]
  end

  # @param args [Hash]
  # @return [String] url with <sub> replaced or removed
  def url_path_sub(args)
    url = args[:url]
    replace_subs(url, args[:sub]) unless (args[:sub].nil? || args[:sub].empty?)
    clean_url_path(url)
  end

  # Iterates through subs array and replaces <sub> string in url with a value from array
  # @param url [String] url containing <sub>
  # @param subs [Array] array of values to replace the /<sub>/ with
  # @return [String] url with the /<sub>/ replaced with values in subs array
  def replace_subs(url, subs)
    subs.each do | replacement |
      url.sub!(/<sub>/, replacement.to_s)
    end
    url
  end
  
  # Strips out /<sub>/ values from the url
  # @param url [String] 
  # @return [String]
  def clean_url_path(url)
    url.gsub(/\/?<sub>\/?/, "")
  end
  
  # Appends parameters to the end of the url
  # @param url [String]
  # @param parameters [Hash] parameters to add to the url
  # @return [String]
  def url_add_parameters(url, parameters)
    url += '?'
    parameters.each do | k, v|
      url += "#{k}=#{v}&"
    end
    url.sub(/&$/, '') #remove trailing &
  end
  
  # Build the url using the base_url and endpoint value. Substitutes url paths and adds parameters if specified
  # @param endpoint [Symbol] endpoint symbol to look up in config hash
  # @param subs [Array] array of values to substitute in url path
  # @param parameters [Hash] hash of parameters to append to the url
  # @return [String]
  def build_url(endpoint, subs=[], parameters={})
    url = base_url + endpoints[endpoint.to_sym]
    url = url_path_sub({url: url, sub: subs})
    url = url_add_parameters(url, parameters) unless parameters.empty?
    url
  end
  
  ### REST calls ###
  def get(url)
    HTTParty.get(url)
  end
  
  def post(url, query={}, headers={})
    HTTParty.post(url, headers: headers, query: query)
  end
  
  def put(url, query={}, headers={})
    HTTParty.put(url, headers: headers, query: query)
  end
  
  def delete(url, query={}, headers={})
    HTTParty.delete(url, headers: headers, query: query)
  end

end
