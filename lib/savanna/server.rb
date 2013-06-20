require "rack"
class Savanna::Server
  def initialize
    puts [Dir.pwd,'www']
    @app = Rack::Builder.new {
      use Rack::Static, :urls => [""], :root => File.expand_path([Dir.pwd,'www'].join('/')), :index => 'index.html'

      map "/assets" do
        assets = ::Savanna::Assets.new
        assets.sprockets
        run assets.sprockets
      end
    }
  end

  def to_app
    @app.to_app
  end
end