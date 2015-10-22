require_relative "04_04_Image"

image = Image.new

puts "image.filter_a.filter_b.filter_c"
puts image.filter_a.filter_b.filter_c

puts "image.filter_a.filter_b.filter_c.header_bytes"
puts image.filter_a.filter_b.filter_c.header_bytes

puts "image.data"
puts image.data

puts "image.filter_a.data"
puts image.filter_a.data