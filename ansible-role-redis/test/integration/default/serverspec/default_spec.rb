require 'spec_helper'
describe port(6379) do
  it { should be_listening.on('0.0.0.0').with('tcp') }
end

if %w(debian ubuntu).include? os[:family]
  conffile = '/etc/redis/redis.conf'
else
  conffile = '/etc/redis.conf'
end
 
describe file(conffile) do
  it { should be_file }
  its(:content) { should match /^bind 0\.0\.0\.0$/ }
end
