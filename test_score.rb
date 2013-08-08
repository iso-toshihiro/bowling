# coding: utf-8

require './score'

describe Score do
  describe "#calcuration" do
    before do 
      @ken = Score.new
      @ken.down_pins_first_roll = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
      @ken.down_pins_second_roll = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      @ken.calcuration(9)

    end

    it "kenの最後のスコアは３００" do
      @ken.display_totalscore[9].should == 300
    end


    after do
    end
  end
end

      
