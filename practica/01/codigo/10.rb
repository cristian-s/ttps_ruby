def a_ul(hash)
        to_ret = '<ul>'
        hash.each {|key,val| to_ret+= "<li>#{key}:#{val}</li>" }
        to_ret += '</ul>'
end

puts a_ul({perros: 1, gatos: 2})
