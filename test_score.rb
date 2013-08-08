# coding: utf-8

require './score'

describe Score do
  describe "#calcuration" do
    before do 
      @ken = Score.new
      @ken.down_pins_first_roll = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
      @ken.down_pins_second_roll = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      @ken.calcuration(9)

      @taro = Score.new
      @taro.down_pins_first_roll = [3, 5, 5, 10, 3, 5, 0, 10, 10, 5, 0, 0]
      @taro.down_pins_second_roll = [3, 0, 5, 0, 4, 5, 0, 0, 0, 1, 0]
      @taro.calcuration(9)

    end

    it "kenの最後のスコアは３００" do
      @ken.totalscores[9].should == 300
    end

    it "taroの最後のスコアは112" do
      @taro.totalscores[9].should == 112
    end

    it "taroの1フレーム目のスコアは6" do
      @taro.totalscores[0].should == 6
    end
    it "taroの2フレーム目のスコアは11" do
      @taro.totalscores[1].should == 11
    end
    it "taroの3フレーム目のスコアは31" do
      @taro.totalscores[2].should == 31
    end
    it "taroの4フレーム目のスコアは48" do
      @taro.totalscores[3].should == 48
    end
    it "taroの5フレーム目のスコアは55" do
      @taro.totalscores[4].should == 55
    end
    it "taroの6フレーム目のスコアは65" do
      @taro.totalscores[5].should == 65
    end
    it "taroの7フレーム目のスコアは65" do
      @taro.totalscores[6].should == 65
    end
    it "taroの8フレーム目のスコアは90" do
      @taro.totalscores[7].should == 90
    end
    it "taroの9フレーム目のスコアは106" do
      @taro.totalscores[8].should == 106
    end

    after do
    end
  end
end

      
