

# Robots can start with 50 shield points. 
# When the robot is damaged it first drains the shield and then starts affecting actual health.

require './spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#shields" do
    it "should be 50" do
      expect(@robot.shields).to eq(50)
    end
  end

  describe "#wound" do
    it "decreases sheilds before decreasing health" do
      @robot.wound(20)
      expect(@robot.health).to eq(100)
      expect(@robot.shields).to eq(30)
    end

    it "damages health after breaking through shields" do
      @robot.wound(120)
      expect(@robot.health).to eq(30)
      expect(@robot.shields).to eq(0)
    end
 
  end

  describe "#heal" do
    it "increases health only, not shields" do
      @robot.wound(90)
      @robot.heal(20)
      expect(@robot.health).to eq(80)
      expect(@robot.shields).to eq(0)
    end

  end

end
