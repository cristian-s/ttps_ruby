class FuckThoseNumbers
  def initialize(app)
    @app = app
  end

  def call(env)
    @status, @headers, @body = @app.call(env)
    @body.collect! do |e|
      e.each_char.inject("") { |str, c| c.to_i.to_s == c ? str += "X" : str += c; str }
    end
    [@status, @headers, @body]
  end
end
