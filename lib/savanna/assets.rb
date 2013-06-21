require "sass"
require 'coffee-script'
require "compass"
require "sprockets"
require "sprockets-sass"

class Savanna::Assets
  ASSET_PATH = []
  ASSET_DIR  = 'assets'
  attr_accessor :sprockets, :root_path

  def self.add_path (path)
    ASSET_PATH << path
  end

  def self.add_path_from_gem (path)
    gem_root_path = File.expand_path('../../', path)
    self.add_path gem_root_path
  end

  def initialize(options)
    @root_path = options[:root_path]
    @sprockets = Sprockets::Environment.new { |env| env.logger = Logger.new(STDOUT) }

    add_append_path @root_path, ASSET_DIR
    add_append_path [@root_path, 'app'].join('/'), ASSET_DIR
    add_append_path [@root_path, 'vendor'].join('/'), ASSET_DIR
    ASSET_PATH.each { |path|
      add_append_path [path, 'app'].join('/')
      add_append_path [path, 'vendor'].join('/')
    }

  end

protected
  def add_append_path (path, dir = 'assets')
    puts "Appended path: #{[path, dir].join('/')}"
    @sprockets.append_path [path, dir, "javascripts"].join('/')
    @sprockets.append_path [path, dir, "images"].join('/')
    @sprockets.append_path [path, dir, "stylesheets"].join('/')
  end
end