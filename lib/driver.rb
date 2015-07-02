require 'pry'
require_relative 'robot'
require_relative 'item'
require_relative 'box_of_bolts'
require_relative 'weapon'
require_relative 'plasma_cannon'
require_relative 'laser'
require_relative 'grenade'

robot = Robot.new
robot2 = Robot.new
grenade = Grenade.new

robot.pick_up(grenade)

binding.pry

puts robot.items
puts robot.equipped_weapon