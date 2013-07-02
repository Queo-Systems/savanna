require "sass"
require 'coffee-script'
require "compass"
require "sprockets"
require "sprockets-sass"
require "yui/compressor"
require "uglifier"
require "pathname"

class Savanna::Assets
  ASSET_PATH = []
  ASSET_DIR  = 'assets'
  attr_accessor :sprockets, :root_path

  def self.add_path_from_gem (path)
    gem_root_path = File.expand_path('../../', path)
    ASSET_PATH << gem_root_path
  end

  def initialize(options)
    @root_path = options[:root_path]
    @sprockets = Sprockets::Environment.new { |env| env.logger = Logger.new(STDOUT) }

    add_append_path @root_path

    ASSET_PATH << @root_path
    ASSET_PATH.each do |path|
      add_append_path [path, 'app'].join('/')
      add_append_path [path, 'vendor'].join('/')
    end

    if options[:precompile]
      @sprockets.css_compressor = ::YUI::CssCompressor.new
      @sprockets.js_compressor  = ::Uglifier.new mangle: true
    end
  end

  def precompile
    precompile_files = load_precompile_files
    output_dir       = File.join @root_path, 'www', 'assets'
    image_dirs       = @sprockets.paths.select { |path| path =~ /\/images$/ }

    FileUtils.rm_rf output_dir

    image_dirs.each do |image_dir|
      copy_images image_dir, to: output_dir
    end

    precompile_files.each do |file|
      asset       = @sprockets[file]
      output_file = Pathname.new(output_dir).join file
      FileUtils.mkdir_p output_file.dirname
      asset.write_to output_file
    end
  end

  def copy_images (original_dir, options)
    FileUtils.cp_r Dir["#{original_dir}/*"], options[:to]
  rescue
    nil
  end

  def load_precompile_files
    precompile_files = []

    list_file = File.join(@root_path, 'savanna')
    if File.exists? list_file
      File.open(list_file).each_line do |line|
        precompile_files << line.gsub(/\n/, '')
      end
      raise EmptyPrecompileList if precompile_files.empty?
    else
      raise FileNotFound
    end

    return precompile_files
  end



protected
  def add_append_path (path, dir = 'assets')
    puts "Appended path: #{[path, dir].join('/')}"
    @sprockets.append_path [path, dir, "javascripts"].join('/')
    @sprockets.append_path [path, dir, "images"].join('/')
    @sprockets.append_path [path, dir, "stylesheets"].join('/')
  end
end