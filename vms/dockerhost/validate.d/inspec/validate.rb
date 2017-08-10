
describe service('docker') do
  it { should be_installed }
  it { should be_running }
end

describe bash('docker-compose version') do
  its('exit_status') { should eq 0 }
end
