require "savanna/version"
require "savanna/assets"
require "savanna/exceptions"
require "savanna/server"
require "rubygems"
require "bundler"

module Savanna
  def self.start_server(options = {})
    port = options[:port] || ENV['PORT'] || 8080
    Rack::Server.start app: Savanna::Server.new.to_app, Port: port, Host: ENV['IP']
  end

  def self.precompile_assets(no_js_compression)
    p "precompile_assets no_js_compression = #{no_js_compression}"
    assets = Savanna::Assets.new(root_path: Dir.pwd, precompile: true, no_js_compression: no_js_compression)
    assets.precompile
  end
end

Bundler.require(:default) if File.exists?('Gemfile')
