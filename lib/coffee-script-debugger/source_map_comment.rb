require 'tilt'

module Sprockets
  class SourceMapComment < Tilt::Template
    def prepare
    end

    def evaluate(context, locals, &block)
      if file =~ /\.coffee/
        #Filter out the source code and the data map
        if data=~/\(function coffee_script_debugger\(\){(.*)}\)/
          json=ActiveSupport::JSON.decode $1
          js=json['js']
          map=ActiveSupport::JSON.decode json['v3SourceMap']
          map['file']=File.basename(file)
          map['sources']=[File.basename(file)]
          #At this point, we have @file available which is the full filename
          # and the context which can give us the logical_path
          copy_map_to_public(map.to_json,context.instance_variable_get(:@logical_path))
          "#{js}\n//@ sourceMappingURL=#{File.basename(file)}.map\n"
        else
          data
        end
      else
        data
      end
    end
    def copy_map_to_public(map,logical_path)
      dir=File.join(Rails.public_path,public_asset_dir(logical_path))
      FileUtils.mkdir_p dir
      fn=File.join(dir,"#{File.basename(file)}.map")
      File.open fn, 'w' do |f|
        f.puts map
      end
      true
    end
    private
    def public_asset_dir(logical_path)
      File.join('assets',File.dirname(logical_path))
    end

  end
end