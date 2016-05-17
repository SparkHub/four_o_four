# Redirector...
require 'utils/asset'

# A small Rack middleware to handle 404 responses with a delegation
class FourOFour
  VERSION = '0.0.2'

  def initialize(app, delegation = nil, skip_formats = [])
    @app = app
    @delegation = (delegation || "#{self.class}::DefaultApplication").to_s
    @skip_formats = Regexp.union(Array(skip_formats))
  end

  def call(env)
    status, headers, response = @app.call(env)

    if !Utils::Asset.match(env['REQUEST_URI']) && can_process_request?(status, headers)
      Object.const_get(@delegation).new.call(env)
    else
      [status, headers, response]
    end
  end

  # Default Application just in case we didn't set up on the middleware
  class DefaultApplication
    def call(_)
      [200, { 'Content-Type' => 'text/html' }, self]
    end

    def each(&block)
      block.call(
        '''
          <h1> Default FourOFour Application </h1>
          Please configure your middleware to pass a delegation class
        ''')
    end
  end

  private

  # Test if the current request can be processed by four_o_four.
  # It will depend on the request and if any skipped formats have been set.
  #
  # @param  [Integer] status Status of the current request.
  # @param  [Rack::Utils::HeaderHash] headers Header of the current request.
  # @return [Boolean]
  #
  # @api private
  def can_process_request?(status, headers)
    content_type = headers['Content-Type']

    404 == status && processable_type?(content_type)
  end

  # Return true if the request type can be processed (try to match with possible skipped formats).
  #
  # @param  [String] content_type Header's content type value.
  # @return [Boolean]
  #
  # @api private
  def processable_type?(content_type)
    content_type.nil? || (content_type && content_type !~ @skip_formats)
  end
end
