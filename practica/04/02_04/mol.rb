Bundler.require

set(:magic_number) do |actual_number|
  magic_number = 42
  condition { magic_number == actual_number }
end

get "/", magic_number: Random.rand(1..42) do
  [200, "VAMO"]
end

get "/" do
  [404, "👎 bajón"]
end
