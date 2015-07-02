require 'pry'
require_relative 'robot'
require_relative 'item'
require_relative 'box_of_bolts'
require_relative 'weapon'
require_relative 'plasma_cannon'
require_relative 'laser'

robot = Robot.new
laser = Laser.new

robot.pick_up(laser)

binding.pry

puts robot.items
puts robot.equipped_weapon