require 'yaml'
require 'httparty'
require 'json'

class RestClient
  attr_reader :config, :service, :base_url, :version, :endpoints
  def initialize(args={})
    @config = args[:config].nil? ? YAML.load_file(File.dirname(__FILE__) + '/../config/url_config.yml') : YAML.load_file(args[:config])
    @service = :jsonplaceholder #args[:service]
    @base_url = config[service][:base]
    @version = args[:version].nil? ? :v1 : args[:version]
    @endpoints = config[service][version]
  end

  # @param args [Hash]
  # @option args [String] :url  url string to cleanup
  # @option args [Array] :sub array containing strings to replace in the url string 
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
      url += "#{k.to_s}=#{v.to_s}&"
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
    url = url_add_parameters(url, parameters) unless (parameters.nil? || parameters.empty?)
    url
  end
  
  # Load json file
  # @param filename [String]
  # @return [Hash]
  def load_json(filename)
    JSON.parse(File.read(filename))
  end
  
  #==== REST calls ====#
  
  # Performs a get call
  # @param args [Hash]
  # @option args [Symbol] :endpoint - endpoint to connect to
  # @option args [Array] :subs - array of values to substitute into <sub> value of url path
  # @option args [Hash] :parameters - url parameters to add to the end of the url
  def get(args)
    url = build_url(args[:endpoint], args[:subs], args[:parameters])
    HTTParty.get(url)
  end
  
  # Performs a post call
  # @param args [Hash]
  # @option args [Symbol] :endpoint - endpoint to connect to
  # @option args [Array] :subs - array of values to substitute into <sub> value of url path
  # @option args [Hash] :parameters - url parameters to add to the end of the url
  # @option args [Hash] :headers - hash of header values to add into request
  # @option args [Hash] :query - hash of body values to add into request
  def post(args)
    url = build_url(args[:endpoint], args[:subs], args[:parameters])
    HTTParty.post(url, headers: args[:headers], query: args[:query])
  end
  
  # Performs a put call
  # @param args [Hash]
  # @option args [Symbol] :endpoint - endpoint to connect to
  # @option args [Array] :subs - array of values to substitute into <sub> value of url path
  # @option args [Hash] :parameters - url parameters to add to the end of the url
  # @option args [Hash] :headers - hash of header values to add into request
  # @option args [Hash] :query - hash of body values to add into request
  def put(args)
    url = build_url(args[:endpoint], args[:subs], args[:parameters])
    HTTParty.put(url, headers: args[:headers], query: args[:query])
  end
  
  # Performs a delete call
  # @param args [Hash]
  # @option args [Symbol] :endpoint - endpoint to connect to
  # @option args [Array] :subs - array of values to substitute into <sub> value of url path
  # @option args [Hash] :parameters - url parameters to add to the end of the url
  # @option args [Hash] :headers - hash of header values to add into request
  # @option args [Hash] :query - hash of body values to add into request
  def delete(args)
    url = build_url(args[:endpoint], args[:subs], args[:parameters])
    HTTParty.delete(url, headers: args[:headers], query: args[:query])
  end

end
