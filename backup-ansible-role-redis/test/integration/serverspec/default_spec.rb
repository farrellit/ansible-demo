require 'spec_helper'
describe port(6379) do
    it { should be_listening.with('tcp') }
end
