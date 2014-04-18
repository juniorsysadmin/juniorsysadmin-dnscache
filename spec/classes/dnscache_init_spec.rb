require 'spec_helper'

describe 'dnscache' do

  context 'on non supported operating systems' do
    let :facts do
      {:osfamily => 'foo'}
    end

    it 'should fail' do
      expect { subject }.to raise_error(/The dnscache module is not supported on a foo based system./)
    end
  end
end
