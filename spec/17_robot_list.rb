
# The Robot class should keep track of all robots that are instantiated.

require './spec_helper'

describe Robot do
  before :each do
    Robot.robots = []
    @robot1 = Robot.create
    @robot2 = Robot.create
  end
  describe ".create" do 
    it "should create a new robot" do
      expect(@robot1).to be_a(Robot)
    end
    it "should place new robot in the robots array" do
      expect(Robot.robots).to match_array [@robot1, @robot2]
    end
  end

end