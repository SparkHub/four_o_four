require 'spec_helper'

describe Utils::Asset do

  describe 'class methods' do

    context 'match' do
      it { expect(Utils::Asset.match('.jpeg')).to be(true) }
      it { expect(Utils::Asset.match('.js')).to   be(true) }
      it { expect(Utils::Asset.match('.mdbx')).to be(true) }
      it { expect(Utils::Asset.match('.json')).to be(false) }
      it { expect(Utils::Asset.match('.html')).to be(false) }
    end
  end
end
