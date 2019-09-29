# returns: [:cold/:hot, :need_bigger/:need_smaller, new_allowed_segment]
def play(guess, allowed_segment)
  if allowed_segment.size == 1 && guess == allowed_segment.first
    return [:correct, nil, nil]
  end

  # guess, ..., lower, ..., upper
  if guess < allowed_segment.first
    if guess + 2 < allowed_segment.first
      return [:cold, :need_bigger, allowed_segment]
    else
      if ((allowed_segment.first)..(guess + 2)).size <= ((guess + 3)..(allowed_segment.last)).size
        return [:cold, :need_bigger, ((guess + 3)..(allowed_segment.last))]
      else
        return [:hot, :need_bigger, ((allowed_segment.first)..(guess + 2))]
      end
    end
  # ..., lower, ..., upper, ..., guess
  elsif allowed_segment.last < guess
    if allowed_segment.last < guess - 2
      return [:cold, :need_smaller, allowed_segment]
    else
      if ((guess - 2)..(allowed_segment.last)).size <= ((allowed_segment.first)..(guess - 3)).size
        return [:cold, :need_smaller, ((allowed_segment.first)..(guess - 3))]
      else
        return [:hot, :need_smaller, ((guess - 2)..(allowed_segment.last))]
      end
    end
  # ..., lower, ..., guess, ..., upper, ...
  else
    if ((allowed_segment.first)..(guess - 1)).size <= ((guess + 1)..(allowed_segment.last)).size
      return play(guess, ((guess + 1)..(allowed_segment.last)))
    else
      return play(guess, (allowed_segment.first)..(guess - 1))
    end
  end
end

puts "Загадано число от 0 до 15. У вас три попытки."

allowed_segment = (0..15)

3.times do
  guess = nil
  until (guess = gets.to_i).between?(0, 15)
    puts "Введите число от 0 до 15"
  end

  hot_or_cold, bigger_or_smaller, allowed_segment = play(guess, allowed_segment)

  if hot_or_cold == :correct
    puts "Вы выиграли!"
    exit
  end

  if hot_or_cold == :hot
    print "Тепло "
  else
    print "Холодно "
  end

  if bigger_or_smaller == :need_smaller
    puts "(нужно меньше)"
  else
    puts "(нужно больше)"
  end
end

puts "Вы проиграли – было загадано #{allowed_segment.to_a.sample}"
