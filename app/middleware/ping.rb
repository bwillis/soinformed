class Ping
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['PATH_INFO'] == '/__ping__'
      [200, {'Content-Type' => 'text/plain'}, ['Pong']]
    else
      @app.call(env)
    end
  end
end
