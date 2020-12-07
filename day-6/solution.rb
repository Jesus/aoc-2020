#!/bin/env ruby
require 'set'

input = File.open('input.txt').each_char.map(&:to_s).join
groups = input.split("\n\n")

# anyone_yes = groups.map do |g|
#   g.strip.chars.filter { |c| c != "\n" } .uniq.size
# end.sum

everyone_yes = groups.map do |group|
  answers = Set.new(group.split("\n").map { |answers| answers.chars })
  puts "Answers: #{answers.to_a.join(', ')}"
  combined_answers = answers.reduce do |acc, answer|
    acc & answer
  end
  puts "Combined: #{combined_answers}"
  (combined_answers || []).size
end.sum

puts everyone_yes
