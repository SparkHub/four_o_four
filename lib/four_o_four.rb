# Redirector...
# A small Rack middleware to handle 404 responses with a delegation
class FourOFour
  VERSION = '0.0.2'
  def initialize(app, delegation = nil)
    @app = app
    @delegation = (delegation || "#{self.class}::DefaultApplication").to_s
  end

  def call(env)
    status, headers, response = @app.call(env)
    if 404 == status
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
end
