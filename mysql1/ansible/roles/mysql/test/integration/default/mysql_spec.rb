# encoding: utf-8

# use basic tests
describe package('mysql') do
  it { should be_installed }
end

# extend tests with metadata
control '01' do
  impact 0.7
  title 'Verify mysql service'
  desc 'Ensures mysql service is up and running'
  describe service('mysql') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

