require 'pry'
require_relative 'robot'
require_relative 'item'
require_relative 'box_of_bolts'
require_relative 'weapon'
require_relative 'plasma_cannon'
require_relative 'laser'
require_relative 'grenade'
require_relative 'battery'

robot = Robot.new
robot2 = Robot.new
grenade = Grenade.new
battery = Battery.new

robot.wound(100)
binding.pry
robot.pick_up(battery)



puts robot.items
puts robot.equipped_weapon