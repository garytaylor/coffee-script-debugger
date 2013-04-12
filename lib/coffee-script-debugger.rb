require "coffee-script-debugger/version"
require "coffee-script-debugger/source_map_comment"
require "sprockets"
require 'sprockets/processing'
require 'sprockets/server'
require 'coffee-script-debugger/coffee_script'

module Sprockets
  class CoffeeScriptDebuggerClass < ::Rails::Railtie
    initializer "coffee.script.debugger", :after => "sprockets.environment" do |app|
      app.assets.register_postprocessor 'application/javascript', SourceMapComment
    end
  end

  module Server
    alias_method :old_call, :call

    def call(env)
      path = unescape(env['PATH_INFO'].to_s.sub(/^\//, ''))
      # URLs containing a `".."` are rejected for security reasons.
      if forbidden_request?(path)
        return forbidden_response
      end

      if path =~/\.coffee/ and path !~/\.map$/
        asset = find_asset(path, :bundle => !body_only?(env), :source => true)
        coffee_file = File.read(asset.pathname)
        [ 200, {'Content-Type' => 'application/javascript'}, [coffee_file] ]
      else
        old_call(env)
      end
    end
  end
end
