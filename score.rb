def validate_low0_high10(roll_points, frame)
  if roll_points[frame] < 0 or roll_points[frame] > 10
    print "Error!!! A number should be inputed between 0 and 10. point is 0.\n"
    roll_points[frame] = 0
    wait_key = gets.chomp
  end
end

def gutter(roll_points, frame)
  if roll_points[frame] == 0
    print "Gutter!!!\n"
    #wait_key = gets.chomp
  end
end

def strike(roll_points, frame)
  if roll_points[frame] == 10 and roll_points[frame-1] == 10
    print "Double!!!!!!\n"
    wait_key = gets.chomp
  elsif roll_points[frame] == 10
    print "Strike!!!!\n"
    wait_key = gets.chomp
  else
  end
end

def spare(first_roll_points, second_roll_points, frame)
  if second_roll_points[frame] + first_roll_points[frame] == 10 and first_roll_points[frame] != 10
    print "spare!!!!\n"
    wait_key = gets.chomp
  end
end

class Score


  attr_accessor :down_pins_first_roll 
  attr_accessor :down_pins_second_roll
  attr_accessor :totalscores
  attr_accessor :first_points
  attr_accessor :second_points

  def initialize
    @down_pins_first_roll  = []
    @down_pins_second_roll = []
    @totalscores           = []
    @first_points          = [] #[2,0,3,10,6,4,3,7,0,6,10]
    @second_points         = [] #[0,1,7,0,4,4,7,7,0,4,3]
    @temp_score            = 0
    # @down_pins_first_roll = [0,0,0,0,0,0,0,0,0,0,0]
    # @down_pins_second_roll = [0,0,0,0,0,0,0,0,0,0,0]
  end

  def validate_roll_point(roll_points, frame, first_or_second, max_point)
    roll_points[frame] = 100
    until  roll_points[frame] >= 0 and  roll_points[frame] <= max_point do
      print "Input a number of ", first_or_second, " point of ", frame+1, " frame between 0 and ", max_point, ".  \n"
      tmp_value = gets.chomp
      if /^\d+$/ =~ tmp_value and tmp_value.to_i <= max_point
        roll_points[frame] = tmp_value.to_i
      else
       puts 'Error!! Input a positive integer.'
      end
    end
  end

  def second_roll(first_roll_points, second_roll_points, frame)
    
    validate_roll_point(second_roll_points, frame, "second", 10 - first_roll_points[frame])
    gutter(second_roll_points, frame)
    
    spare(first_roll_points, second_roll_points, frame)

    if second_roll_points[frame] + first_roll_points[frame] > 10 
      print "Error!!! over 10 points. input 0.\n"
      second_roll_points[frame] = 0
      wait_key = gets.chomp
    end
    validate_low0_high10( second_roll_points, frame )
  end

  def case_10frame_strike(first_roll_points, second_roll_points)
    if first_roll_points[9] == 10
      validate_roll_point(first_roll_points, 10, "first", 10)

      if first_roll_points[10] == 10
        validate_roll_point(first_roll_points, 11, "first", 10)
      else
        validate_roll_point(second_roll_points, 10, "second", 10 - first_roll_points[10])
      end
    end
  end

  def case_10frame_spare(first_roll_points, second_roll_points)
    if first_roll_points[9] + second_roll_points[9] == 10 and  first_roll_points[9] != 10
      validate_roll_point(first_roll_points, 10, "last", 10)
    end
  end

  def input  #input score

    for i in 0..9
      validate_roll_point(@down_pins_first_roll, i, "first", 10)

      gutter(@down_pins_first_roll, i)
      strike(@down_pins_first_roll, i)
      validate_low0_high10( @down_pins_first_roll, i )

      if @down_pins_first_roll[i] == 10
        @down_pins_second_roll[i] = 0
      else
        self.second_roll(@down_pins_first_roll, @down_pins_second_roll, i)
      end
      self.calcuration(i)
      self.display2(i)
      #self.display(i)
      
    end #for_end

    self.case_10frame_strike(@down_pins_first_roll, @down_pins_second_roll)
    self.case_10frame_spare(@down_pins_first_roll, @down_pins_second_roll)
  end

  def cal_case_strike(frame)
    if  @down_pins_first_roll[frame] == 10
      @first_points[frame] = "X"
      @second_points[frame] = " "
      if  @down_pins_first_roll[frame+1] == nil
        @totalscores[frame] = " "
        
      elsif @down_pins_first_roll[frame+1] == 10 and @down_pins_first_roll[frame+2] == nil
        @totalscores[frame] = " "
      elsif  @down_pins_first_roll[frame+1] == 10 and @down_pins_first_roll[frame+2] != nil
        @totalscores[frame] = @temp_score + 20 + @down_pins_first_roll[frame+2]
        @temp_score += 20 + @down_pins_first_roll[frame+2]
      else
        @totalscores[frame] = @temp_score + 10 + @down_pins_first_roll[frame+1] + @down_pins_second_roll[frame+1]
        @temp_score += 10 + @down_pins_first_roll[frame+1] + @down_pins_second_roll[frame+1]
      end
    else
      return false
    end
  end

  def cal_case_spare(frame)
    if  @down_pins_first_roll[frame] + @down_pins_second_roll[frame] == 10  and @down_pins_first_roll[frame] != 10
      @first_points[frame] = @down_pins_first_roll[frame]
      @second_points[frame] = "/"
      if  @down_pins_first_roll[frame+1] == nil
        @totalscores[frame] = " "
      else
        @totalscores[frame] = @temp_score + 10 + @down_pins_first_roll[frame+1]
        @temp_score += 10 + @down_pins_first_roll[frame+1]
      end
    else
      return false
    end
  end
  def cal_case_10frame_strike
    if @down_pins_first_roll[9] == 10 
      if @down_pins_first_roll[10] == 10
        @first_points[10] = "X"
      else
        @first_points[10] =  @down_pins_first_roll[10]
        @second_points[10] =  @down_pins_second_roll[10]
      end
      if @down_pins_first_roll[11] == 10
        @first_points[11] = "X"
      else
        @first_points[11] =  @down_pins_first_roll[11]
      end
    else
      return false
    end
  end
  
  def cal_case_10frame_spare
    if  @down_pins_first_roll[9] + @down_pins_second_roll[9] == 10 and  @down_pins_first_roll[9] != 10
      if  @down_pins_first_roll[10] == 10
        @first_points[10] = "X"
      else
        @first_points[10] =  @down_pins_first_roll[10]
      end
    end
  end

  def calcuration(frame)
    
    #@first_points = [2,0,3,10,6,4,3,7,0,6,10]
    #@second_points = [0,1,7,0,4,4,7,7,0,4,3]
    #@totalscores = [3,1,7,0,4,4,7,7,0,4,3]
    @temp_score = 0
    
    if frame == 9  
      cal_case_10frame_strike
      cal_case_10frame_spare
    end

    for i in 0..frame

      if cal_case_strike(i) == false and cal_case_spare(i) == false
        print i,"  ", @temp_score," OK\n"
        @first_points[i] = @down_pins_first_roll[i]
        @second_points[i] =  @down_pins_second_roll[i]
        @totalscores[i] = @temp_score + @down_pins_first_roll[i] + @down_pins_second_roll[i]
        @temp_score += @down_pins_first_roll[i] + @down_pins_second_roll[i]
      end
    end #for end
  end

  def display2(frame) 
    for i in 0..frame
      
      if i == 9 
        if @down_pins_first_roll[9] == 10 and @down_pins_first_roll[10] == 10
          print "   ", @first_points[i], "  ", @first_points[i + 1], " ", @first_points[i + 2], "|"
        elsif  @down_pins_first_roll[9] == 10
          print "   ", @first_points[i], "  ", @first_points[i + 1], " ", @second_points[i + 1], "|"
        elsif @down_pins_first_roll[9] +  @down_pins_second_roll[9] == 10
          print "   ", @first_points[i], "  ", @second_points[i], " ", @first_points[i + 1], "|"
        else
          print "   ", @first_points[i], " ", @second_points[i], "|"
        end
      else
        print "   ", @first_points[i], " ", @second_points[i], "|"
      end
    end
    print "\n"

    
    for i in 0..frame
      
      
      if i == 9 
        if  @down_pins_first_roll[9] + @down_pins_second_roll[9] == 10
          if  @totalscores[9] == " "
            print "    ", "%3s" % @totalscores[i], "|"
          else
            print "      ", "%3d" % @totalscores[i], "|"
          end
        else
          print "   ", "%3d" % @totalscores[i], "|"
        end
      else
        if  @totalscores[i] == " "
          print "   ", "%3s" % @totalscores[i], "|"
        else
          print "   ", "%3d" % @totalscores[i], "|"
        end
      end
    end #for end
    
    print "\n"
    print " X : strike\n / : spare\n"

  end

end # class end

bob = Score.new

ary = [3,3.3,"ff"]
p ary[0].class
p ary[1].class
p ary[2].class
bob.input
#bob.firstpoint = [10,10,10,10,10,10,10,10,10,10,10,10,10]
#bob.secondpoint = [0,0,0,0,0,0,0,0,0,0,0]
bob.calcuration(9)
#print bob.totalscores[9]
bob.display2(9)
