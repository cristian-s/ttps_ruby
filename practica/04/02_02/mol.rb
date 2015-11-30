class MoL
  def call(env)
    number = Random.rand(1..42)
    if number == 42
      [200, {}, ["#{number}"]]
    else
      [404, {}, ["#{number}"]]
    end
  end
end
