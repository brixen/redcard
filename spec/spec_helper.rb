require 'redcard'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

class RedCard
  module Specs
    @verbose = nil
    @ruby_version = nil
    @engine = nil
    @engine_version = nil

    def self.save_state
      @verbose = $VERBOSE
      $VERBOSE = nil
      @ruby_version = RUBY_VERSION
      @ruby_engine = RedCard.engine
    end

    def self.save_engine_version
      @engine_version = RedCard.engine_version
    end

    def self.restore_state
      $VERBOSE = nil
      Object.const_set :RUBY_VERSION, @ruby_version

      engine_version = @engine_version ? @engine_version : nil
      Object.const_set :RUBY_ENGINE, @ruby_engine

      $VERBOSE = @verbose
    end

    def self.version=(version)
      Object.const_set :RUBY_VERSION, version
    end

    def self.engine=(engine)
      Object.const_set :RUBY_ENGINE, engine
    end

    def self.engine_version=(version)
      case RedCard.engine
      # when "ironruby"
        # TODO
      when "jruby"
        Object.const_set :JRUBY_VERSION, version
      # when "maglev"
        # TODO
      when "rbx"
        unless defined?(::Rubinius)
          Object.const_set :Rubinius, Module.new
        end
        Object.const_get(:Rubinius).const_set(:VERSION, version)
      when "ruby"
        RUBY_VERSION
      when "topaz"
        unless defined?(::Topaz)
          Object.const_set :Topaz, Module.new
        end
        Object.const_get(:Topaz).const_set(:VERSION, version)
      end
    end
  end
end

def redcard_save_state
  RedCard::Specs.save_state
end

def redcard_restore_state
  RedCard::Specs.restore_state
end

def redcard_unload(path)
  $".delete "#{path}.rb"
  $".delete File.expand_path("../../lib/#{path}.rb", __FILE__)
end

def redcard_version(version)
  RedCard::Specs.version = version
end

def redcard_engine(engine)
  RedCard::Specs.engine = engine
end

def redcard_engine_version(version)
  RedCard::Specs.save_engine_version
  RedCard::Specs.engine_version = version
end
