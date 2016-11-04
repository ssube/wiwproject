describe 'wiwproject::db' do
  describe package('mysql') do
    it { should be_installed }
  end

  describe service('mysql') do
    it { should be_enabled }
    it { should be_running }
  end
end
