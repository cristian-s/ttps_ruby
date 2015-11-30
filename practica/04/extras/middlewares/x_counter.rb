class XCounter
  def initialize(app)
    @app = app
  end

  def call(env)
    @status, @headers, @body = @app.call(env)
    x_counter = 0
    @body.each { |e| e.each_char { |c| x_counter += 1 if c == "X" } }
    @headers["X-Xs-Counter"] = x_counter.to_s
    [@status, @headers, @body]
  end
end
