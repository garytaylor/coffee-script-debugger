# encoding: utf-8

require 'execjs'
require 'coffee_script/source'

module CoffeeScript
  EngineError      = ExecJS::RuntimeError
  CompilationError = ExecJS::ProgramError

  module Source

    def self.path
      @path ||= ENV['COFFEESCRIPT_SOURCE_PATH'] || bundled_path
    end

    def self.path=(path)
      @contents = @version = @bare_option = @context = nil
      @path = path
    end

    def self.contents
        @contents ||= File.read(path).encode!('UTF-8', 'UTF-8', :invalid => :replace)
    end

    def self.version
      @version ||= contents[/CoffeeScript Compiler v([\d.]+)/, 1]
    end

    def self.bare_option
      @bare_option ||= contents.match(/noWrap/) ? 'noWrap' : 'bare'
    end

    def self.context
      @context ||= ExecJS.compile(contents)
    end
  end

  class << self
    def engine
    end

    def engine=(engine)
    end

    def version
      Source.version
    end

    # Compile a Coffee Script Redux file to JavaScript
    # or generate the source maps.
    #
    # @param [String,#read] the source string or IO
    # @param [Hash] options the compiler options
    # @option options [Boolean] bare compile the JavaScript without the top-level function safety wrapper
    # @option options [String] format the output format, either `:map` or `:js`
    #
    def compile(script, options = {})
      script = script.read if script.respond_to?(:read)

      if options.key?(:bare)
      elsif options.key?(:no_wrap)
        options[:bare] = options[:no_wrap]
      else
        options[:bare] = false
      end

      o=Source.context.call("(function(script){return CoffeeScript.compile(script,{sourceMap:true})})",script)
      "(function coffee_script_debugger(){#{o.to_json}})"
    end
  end
end
