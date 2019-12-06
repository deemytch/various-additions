module Checksum
  module_function
  def okpo?( n )
    text = n.to_s
    return false unless [ 8, 10 ].include?( text.length )
    mul = 1
    control = text.split('')[1..-2].reduce( text[0].to_i ){ |sum, x| sum + x.to_i * (mul += 1) } % 11
    if control > 9
      mul = 3
      control = text.split('')[1..-2].reduce( text[0].to_i ){ |sum, x| sum + x.to_i * (mul += 1) } % 11
    end
    control = 0 if control > 9
    control == text[-1].to_i
  end

  def inn?( n )
    text = n.to_s.freeze
    return false unless [ 10, 12 ].include?(text.length)
    w = [
      [ 7, 2, 4, 10, 3, 5, 9, 4, 6, 8 ],
      [ 3, 7, 2, 4, 10, 3, 5, 9, 4, 6, 8 ],
      [ 2, 4, 10, 3, 5, 9, 4, 6, 8 ]
    ].freeze
    if text.length == 12
      i = -1
      n2 = text.split('')[0..-3].reduce(0){ |sum, x| sum + x.to_i * w[0][i += 1] } % 11
      n2 = 0 if n2 == 10

      i = -1
      n1 = text.split('')[0..-2].reduce(0){ |sum, x| sum + x.to_i * w[1][i += 1] } % 11
      n1 = 0 if n1 == 10

      return ( text[-2].to_i == n2 && text[-1].to_i == n1 )
    else
      i = -1
      n1 = text.split('')[0..-2].reduce(0){ |sum, x| sum + x.to_i * w[2][i += 1] } % 11
      n1 = 0 if n1 == 10

      return ( text[-1].to_i == n1 )
    end
  end
end
