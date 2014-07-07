require "sass"
require 'coffee-script'
require "compass"
require "sprockets"
require "sprockets-helpers"
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
    @sprockets = Sprockets::Environment.new do |env|
      env.logger = Logger.new(STDOUT)

      define_children_directories [@root_path] + ASSET_PATH do |path|
        env.append_path path
      end

      Sprockets::Helpers.configure do |config|
        config.environment = env
        config.prefix      = "/#{ASSET_DIR}"
        config.digest      = false
      end

      if options[:precompile]
        env.css_compressor = :scss
        env.js_compressor  = ::Uglifier.new mangle: true
      end
    end
  end

  def precompile
    precompile_files = load_precompile_files
    @output_dir      = File.join @root_path, 'www', 'assets'

    FileUtils.rm_rf @output_dir
    FileUtils.mkdir_p @output_dir

    copy_static_folders 'images', 'fonts'

    precompile_files.each do |file|
      asset       = @sprockets[file]
      raise FileNotFound.new file if asset.nil?
      output_file = Pathname.new(@output_dir).join file
      FileUtils.mkdir_p output_file.dirname
      asset.write_to output_file
    end
  end

  def copy_static_folders(*folders)
    dirs = []
    folders.each do |folder|
      dirs += @sprockets.paths.select { |path| path =~ /\/#{folder}$/ }
    end
    dirs.each do |dir|
      begin
        FileUtils.cp_r Dir["#{dir}/*"], @output_dir
      rescue
        nil
      end
    end
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
      raise PrecompileFileNotFound
    end

    return precompile_files
  end



protected
  def define_children_directories (paths, asset_dir = 'assets')
    paths.each do |path|
      ['', 'app', 'vendor'].each do |dir|
        puts "Appended path: #{File.join(path, dir, asset_dir)}"
        yield File.join(path, dir, asset_dir, "fonts")
        yield File.join(path, dir, asset_dir, "javascripts")
        yield File.join(path, dir, asset_dir, "images")
        yield File.join(path, dir, asset_dir, "stylesheets")
      end
    end
  end
end