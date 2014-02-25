require 'spec_helper'

describe 'dnscache' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "dnscache class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('dnscache::params') }
        it { should contain_class('dnscache::install').that_comes_before('dnscache::config') }
        it { should contain_class('dnscache::config') }
        it { should contain_class('dnscache::service').that_subscribes_to('dnscache::config') }

        it { should contain_service('dnscache') }
        it { should contain_package('dnscache').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'dnscache class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('dnscache') }.to raise_error(Puppet::Error, /"The dnscache module is not supported on a Solaris based system."/) }
    end
  end
end
