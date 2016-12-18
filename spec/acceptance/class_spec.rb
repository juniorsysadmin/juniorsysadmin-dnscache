require 'spec_helper_acceptance'

describe 'dnscache class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    # rubocop:disable RSpec/MultipleExpectations
    it 'is expected to work with no errors' do
      pp = <<-EOS
      class { 'dnscache': }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).not_to eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end
    # rubocop:enable RSpec/MultipleExpectations

    describe package('dnscache') do
      it { is_expected.to be_installed }
    end

    describe service('dnscache') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
