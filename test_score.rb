﻿# coding: utf-8

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
      @ken.display_totalscore[9].should == 300
    end

    it "taroの最後のスコアは112" do
      @taro.display_totalscore[9].should == 112
    end

    it "taroの１フレーム目のスコアは6" do
      @taro.display_totalscore[0].should == 6
    end
    it "taroの２フレーム目のスコアは11" do
      @taro.display_totalscore[1].should == 11
    end
    it "taroの3フレーム目のスコアは31" do
      @taro.display_totalscore[2].should == 31
    end
    it "taroの4フレーム目のスコアは48" do
      @taro.display_totalscore[3].should == 48
    end
    it "taroの5フレーム目のスコアは55" do
      @taro.display_totalscore[4].should == 55
    end
    it "taroの6フレーム目のスコアは65" do
      @taro.display_totalscore[5].should == 65
    end
    it "taroの7フレーム目のスコアは65" do
      @taro.display_totalscore[6].should == 65
    end
    it "taroの8フレーム目のスコアは90" do
      @taro.display_totalscore[7].should == 90
    end
    it "taroの9フレーム目のスコアは106" do
      @taro.display_totalscore[8].should == 106
    end

    after do
    end
  end
end

      
