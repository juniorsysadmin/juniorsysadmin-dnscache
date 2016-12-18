require 'spec_helper'

describe 'dnscache', type: :class do
  context 'Fedora with no parameters, 64 bit' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystem: 'Fedora',
        architecture: 'x86_64'
      }
    end
    it { is_expected.to compile.with_all_deps }
  end

  context 'Ubuntu with no parameters' do
    let(:facts) do
      {
        lsbdistid: 'ubuntu',
        lsbdistcodename: 'trusty',
        lsbdistrelease: '14.04',
        osfamily: 'Debian',
        operatingsystem: 'Ubuntu',
        architecture: 'x86_64'
      }
    end
    it { is_expected.to compile.with_all_deps }
  end
end
