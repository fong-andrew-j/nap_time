require 'rest_client'
require_relative 'spec_helper.rb'

describe RestClient do
  before(:each) do
    @rest_client = RestClient.new
  end

  it "should replace the <sub> values in the url" do
     url = @rest_client.url_path_sub(url: 'http://jsonplaceholder.typicode.com/posts/<sub>/<sub>', sub: [1, 'comments'])
     expect(url).to eq('http://jsonplaceholder.typicode.com/posts/1/comments')
  end
  
  it "should clean up <sub> values in the url if substitution hash is empty" do
    url = @rest_client.url_path_sub(url: 'http://jsonplaceholder.typicode.com/posts/<sub>/<sub>', sub: [])
    expect(url).to eq('http://jsonplaceholder.typicode.com/posts')
  end
  
  it "should add parameters to the URL" do
    url = @rest_client.url_add_parameters('http://jsonplaceholder.typicode.com/comments', { 'postId' => 1})
    expect(url).to eq('http://jsonplaceholder.typicode.com/comments?postId=1')
  end
end

