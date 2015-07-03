# The Robot class can be asked to return all robots in a given position (x,y). 
# It should return an array of all the robots since multiple robots could potentially be at position 0,0 (for example)

require './spec_helper'

describe Robot do
  before :each do
    Robot.robots = []
    @robot1 = Robot.create
    @robot2 = Robot.create
    @robot3 = Robot.create
  end

  describe ".in_position" do
    it "should return an array of all robots in a given position" do
      expect(Robot.in_position(0,0)).to match_array [@robot1, @robot2, @robot3]
    end

    it "should not return robots in a different position" do
      @robot3.move_up
      expect(Robot.in_position(0,1)).to match_array [@robot3]
    end  
  end


end