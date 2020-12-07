#!/bin/env ruby

def bsp(code, upper_char, lower_char)
  code.each_char.reduce(0) do |acc, c|
    if c == upper_char
      (acc << 1) + 1
    elsif c == lower_char
      acc << 1
    else
      raise ArgumentError, "Unrecognized character: #{c}"
    end
  end
end

Seat = Struct.new(:row, :column) do
  def self.from_boarding_pass_code(line)
    Seat.new(
      bsp(line[0...7], 'B', 'F'),
      bsp(line[7...10], 'R', 'L')
    )
  end

  def id
    row * 8 + column
  end
end

seats = File.open('input.txt').map do |line|
  Seat.from_boarding_pass_code(line)
end

seat_ids = seats.map(&:id)

my_seat = 0.upto(seat_ids.max) do |n|
  next if seat_ids.include? n
  if seat_ids.include?(n - 1) && seat_ids.include?(n + 1)
    puts n
  end
end
