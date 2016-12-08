require 'spec_helper'

describe FourOFour do
  it 'has a version number' do
    expect(FourOFour::VERSION).not_to be nil
  end
  describe 'It works as a Rack Middleware' do
    let(:app) { proc { [200, {}, ['Hello World.']] } }
    let(:stack) { described_class.new(app) }
    let(:request) { Rack::MockRequest.new(stack) }

    describe 'Is a compatible Rack App?' do
      let(:response) { request.get('/') }
      it { expect(response.status).to eq(200) }
    end

    describe 'Should not affecte the flow on non-404 responses' do
      let(:response) { request.get('/') }
      it { expect(response.body).to eq('Hello World.') }
    end
  end

  describe 'Should only process on GET request methods' do
    let(:app) { proc { [404, {}, ['Hello World.']] } }
    let(:stack) { described_class.new(app) }
    let(:request) { Rack::MockRequest.new(stack) }

    let(:response) { request.post('/') }
    it { expect(response.status).to eq(404) }
  end

  describe 'It can have options' do

    describe 'It should skip specific formats if an option is given' do
      let(:app) { proc { [404, {'Content-Type' => 'application/json'}, ['Hello World.']] } }
      let(:stack) { described_class.new(app, nil, 'application/json') }
      let(:request) { Rack::MockRequest.new(stack) }

      let(:response) { request.get('/') }
      it { expect(response.status).to eq(404) }
    end
  end

  describe 'Returns the Default Message on 404' do
    let(:app) do
      Rack::Builder.new do
        use FourOFour
        map '/' do
          run proc { [404, {}, ['Application Error']] }
        end
      end
    end
    let(:response) { Rack::MockRequest.new(app).get('/') }
    it { expect(response.status).to eq(200) }
  end
end
