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

  def self.precompile_assets
    assets = Savanna::Assets.new(root_path: Dir.pwd, precompile: true)
    assets.precompile
  end
end

Bundler.require(:default) if File.exists?('Gemfile')
