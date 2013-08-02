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
  attr_accessor :display_totalscore
  attr_accessor :display_firstpoint
  attr_accessor :display_secondpoint

  def initialize
    @down_pins_first_roll  = []
    @down_pins_second_roll = []
    @display_totalscore    = []
    @display_firstpoint    = [] #[2,0,3,10,6,4,3,7,0,6,10]
    @display_secondpoint   = [] #[0,1,7,0,4,4,7,7,0,4,3]
    @totalscore            = 0
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
      print "Input a number of first roll point of last frame between 0 and 10.  \n"
      first_roll_points[10] = gets.chomp.to_i
      validate_low0_high10( first_roll_points, 10 )
      if first_roll_points[10] == 10
        print "Input a number of second roll point of last frame between 0 and 10.  \n"
        first_roll_points[11] = gets.chomp.to_i
        validate_low0_high10( first_roll_points, 11 )
      else
        print "Input a number of second roll point of last frame between 0 and 10.  \n"
        second_roll_points[10] = gets.chomp.to_i
        validate_low0_high10(second_roll_points, 10)
      end
    end
  end

  def case_10frame_spare(first_roll_points, second_roll_points)
    if first_roll_points[9] + second_roll_points[9] == 10 and  first_roll_points[9] != 10
      print "Input a number of last raoll point between 0 and 10.  \n"
      first_roll_points[10] = gets.chomp.to_i
      validate_low0_high10(first_roll_points, 10)
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
      @display_firstpoint[frame] = "X"
      @display_secondpoint[frame] = " "
      if  @down_pins_first_roll[frame+1] == nil
        @display_totalscore[frame] = " "
        
      elsif @down_pins_first_roll[frame+1] == 10 and @down_pins_first_roll[frame+2] == nil
        @display_totalscore[frame] = " "
      elsif  @down_pins_first_roll[frame+1] == 10 and @down_pins_first_roll[frame+2] != nil
        @display_totalscore[frame] = @totalscore + 20 + @down_pins_first_roll[frame+2]
        @totalscore += 20 + @down_pins_first_roll[frame+2]
      else
        @display_totalscore[frame] = @totalscore + 10 + @down_pins_first_roll[frame+1] + @down_pins_second_roll[frame+1]
        @totalscore += 10 + @down_pins_first_roll[frame+1] + @down_pins_second_roll[frame+1]
      end
    else
      return false
    end
  end

  def cal_case_spare(frame)
    if  @down_pins_first_roll[frame] + @down_pins_second_roll[frame] == 10  and @down_pins_first_roll[frame] != 10
      @display_firstpoint[frame] = @down_pins_first_roll[frame]
      @display_secondpoint[frame] = "/"
      if  @down_pins_first_roll[frame+1] == nil
        @display_totalscore[frame] = " "
      else
        @display_totalscore[frame] = @totalscore + 10 + @down_pins_first_roll[frame+1]
        @totalscore += 10 + @down_pins_first_roll[frame+1]
      end
    else
      return false
    end
  end
  def cal_case_10frame_strike
    if @down_pins_first_roll[9] == 10 
      if @down_pins_first_roll[10] == 10
        @display_firstpoint[10] = "X"
      else
        @display_firstpoint[10] =  @down_pins_first_roll[10]
        @display_secondpoint[10] =  @down_pins_second_roll[10]
      end
      if @down_pins_first_roll[11] == 10
        @display_firstpoint[11] = "X"
      else
        @display_firstpoint[11] =  @down_pins_first_roll[11]
      end
    else
      return false
    end
  end
  
  def cal_case_10frame_spare
    if  @down_pins_first_roll[9] + @down_pins_second_roll[9] == 10 and  @down_pins_first_roll[9] != 10
      if  @down_pins_first_roll[10] == 10
        @display_firstpoint[10] = "X"
      else
        @display_firstpoint[10] =  @down_pins_first_roll[10]
      end
    end
  end

  def calcuration(frame)
    
    #@display_firstpoint = [2,0,3,10,6,4,3,7,0,6,10]
    #@display_secondpoint = [0,1,7,0,4,4,7,7,0,4,3]
    #@display_totalscore = [3,1,7,0,4,4,7,7,0,4,3]
    @totalscore = 0
    
    if frame == 9  
      cal_case_10frame_strike
      cal_case_10frame_spare
    end

    for i in 0..frame

      if cal_case_strike(i) == false and cal_case_spare(i) == false
        print i,"  ", @totalscore," OK\n"
        @display_firstpoint[i] = @down_pins_first_roll[i]
        @display_secondpoint[i] =  @down_pins_second_roll[i]
        @display_totalscore[i] = @totalscore + @down_pins_first_roll[i] + @down_pins_second_roll[i]
        @totalscore += @down_pins_first_roll[i] + @down_pins_second_roll[i]
      end
    end #for end
  end

  def display2(frame) 
    for i in 0..frame
      
      if i == 9 
        if @down_pins_first_roll[9] == 10 and @down_pins_first_roll[10] == 10
          print "   ", @display_firstpoint[i], "  ", @display_firstpoint[i + 1], " ", @display_firstpoint[i + 2], "|"
        elsif  @down_pins_first_roll[9] == 10
          print "   ", @display_firstpoint[i], "  ", @display_firstpoint[i + 1], " ", @display_secondpoint[i + 1], "|"
        elsif @down_pins_first_roll[9] +  @down_pins_second_roll[9] == 10
          print "   ", @display_firstpoint[i], "  ", @display_secondpoint[i], " ", @display_firstpoint[i + 1], "|"
        else
          print "   ", @display_firstpoint[i], " ", @display_secondpoint[i], "|"
        end
      else
        print "   ", @display_firstpoint[i], " ", @display_secondpoint[i], "|"
      end
    end
    print "\n"

    
    for i in 0..frame
      
      
      if i == 9 
        if  @down_pins_first_roll[9] + @down_pins_second_roll[9] == 10
          if  @display_totalscore[9] == " "
            print "    ", "%3s" % @display_totalscore[i], "|"
          else
            print "      ", "%3d" % @display_totalscore[i], "|"
          end
        else
          print "   ", "%3d" % @display_totalscore[i], "|"
        end
      else
        if  @display_totalscore[i] == " "
          print "   ", "%3s" % @display_totalscore[i], "|"
        else
          print "   ", "%3d" % @display_totalscore[i], "|"
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
#print bob.display_totalscore[9]
bob.display2(9)
