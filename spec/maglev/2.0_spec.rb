require 'spec_helper'

describe "MagLev version requirement" do
  before do
    redcard_save_state
    redcard_unload "redcard/maglev/2.0"
  end

  after do
    redcard_restore_state
  end

  it "succeeds if RUBY_ENGINE is 'maglev' and MAGLEV_VERSION is greater than or equal to 2.0" do
    redcard_engine "maglev"
    redcard_engine_version "2.0.0"
    expect { require 'redcard/maglev/2.0' }.not_to raise_error
  end

  it "raises an InvalidRubyEngineError if RUBY_ENGINE is 'topaz'" do
    redcard_engine "topaz"
    redcard_engine_version "2.0.0"
    expect { require 'redcard/maglev/2.0' }.to raise_error(RedCard::InvalidRubyError)
  end

  it "raises an InvalidRubyEngineError if RUBY_ENGINE is 'rbx'" do
    redcard_engine "rbx"
    redcard_engine_version "2.0.0"
    expect { require 'redcard/maglev/2.0' }.to raise_error(RedCard::InvalidRubyError)
  end

  it "raises an InvalidEngineVersionError if MAGLEV_VERSION is less than 2.0" do
    redcard_engine "maglev"
    redcard_engine_version "1.0.0"
    expect { require 'redcard/maglev/2.0' }.to raise_error(RedCard::InvalidRubyError)
  end
end
