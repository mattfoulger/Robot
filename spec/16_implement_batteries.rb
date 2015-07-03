# Batteries are items that can be used by robot to recharge its shield.
#  Implement Battery item that can be used to recharge the Robot’s shield. 
#  Batteries have a weight of 25.

require './spec_helper'

describe Battery do
  before :each do
    @battery = Battery.new
  end

  it "should be an item" do
    expect(@battery).to be_an(Item)
  end

  it "has name 'Battery'" do
    expect(@battery.name.downcase).to eq("battery")
  end

  it "has 25 weight" do
    expect(@battery.weight).to eq(25)
  end

  describe "#charge" do
    it "charges the robot's shields to max value" do
      @robot = Robot.new
      @robot.wound(100)
      expect(@robot.shields).to eq(0)
      @robot.pick_up(@battery)
      expect(@robot.items).to eq([@battery])
      expect(@robot.shields).to eq(50)
    end
  end
end
