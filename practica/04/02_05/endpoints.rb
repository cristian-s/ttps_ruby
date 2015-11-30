Bundler.require
require_relative "../extras/middlewares/FuckThoseNumbers"
require_relative "../extras/middlewares/x_counter"

use XCounter
use FuckThoseNumbers

get "/" do
  body = []
  Sinatra::Application.each_route do |route|
    body.push("#{route.verb} #{route.path}<br>")
  end
  [200, {}, body]
end

get "/mcm/:a/:b" do |a, b|
  [200, {}, [a.to_i.lcm(b.to_i).to_s]]
end

get "/mcd/:a/:b" do |a, b|
  [200, {}, [a.to_i.gcd(b.to_i).to_s]]
end

get "/sum/*" do |args|
  [200, {}, [args.split("/").inject(0) {|sum, each| sum + each.to_i}.to_s]]
end

get "/even/*" do |args|
  [200, {}, [args.split("/").select {|n| n.to_i.even?}.size.to_s]]
end

post "/random" do
  [200, {}, [rand.to_s]]
end

post "/random/:lower/:upper" do |lower, upper|
  [200, {}, [Random.rand(lower.to_i..upper.to_i).to_s]]
end
