require "rack"
class Savanna::Server
  def initialize
    root_path = Dir.pwd
    @app = Rack::Builder.new {

      map "/" do
        use Rack::Static, :urls => [""], :root => File.expand_path([root_path,'www'].join('/')), :index => 'index.html'
        run lambda {|*|}
      end

      map "/assets" do
        assets = ::Savanna::Assets.new root: root_path
        assets.sprockets
        run assets.sprockets
      end
    }
  end

  def to_app
    @app.to_app
  end
end