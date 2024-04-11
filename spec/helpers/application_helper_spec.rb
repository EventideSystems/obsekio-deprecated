# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '.recaptcha_with_nonce' do
    subject { helper.recaptcha_with_nonce(action: 'test') }

    let(:site_key) { 'test' }
    let(:subject_string) { subject.to_str.chomp }

    before do
      allow(Recaptcha.configuration).to receive(:site_key).and_return(site_key)
    end

    it { is_expected.to be_a(ActiveSupport::SafeBuffer) }

    describe 'contents' do
      it { expect(subject_string).to match(%r{<input type="hidden".*/>}) }
      it { expect(subject_string).to include('name="g-recaptcha-response-data[test]"') }
      it { expect(subject_string).to include('id="g-recaptcha-response-data-test"') }
      it { expect(subject_string).to include('class="g-recaptcha g-recaptcha-response "') }
    end

    context 'when site_key is not set' do
      let(:site_key) { nil }

      it { is_expected.to be_nil }
    end
  end
end
