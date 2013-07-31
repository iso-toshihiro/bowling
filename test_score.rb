# coding: utf-8

require './score'

describe Score do
  describe "#calcuration" do
    before do 
      @ken = Score.new
      
      @ken.firstpoint = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
      @ken.secondpoint = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      @ken.calcuration(9)
    end

    it "最後のスコアは３００" do
      @ken.display_totalscore[9].should == 300
    end


    after do
    end
  end
end

      
