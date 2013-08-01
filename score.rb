def validate_low0_high10(rollpoint_array, frame)
     if rollpoint_array[frame] < 0 or rollpoint_array[frame] > 10
       print "Error!!! A number should be inputed between 0 and 10. point is 0.\n"
       rollpoint_array[frame] = 0
       wait_key = gets.chomp
     end
end

def gutter(rollpoint_array, frame)
      if rollpoint_array[frame] == 0
        print "Gutter!!!\n"
        #wait_key = gets.chomp
      end
end

def strike(rollpoint_array, frame)
      if rollpoint_array[frame] == 10 and rollpoint_array[frame-1] == 10
          print "Double!!!!!!\n"
          wait_key = gets.chomp
      elsif rollpoint_array[frame] == 10
          print "Strike!!!!\n"
          wait_key = gets.chomp
      else
      end
end

def validate_spare(first_rollpoint_array, second_rollpoint_array, frame)
    if second_rollpoint_array[frame] + first_rollpoint_array[frame] == 10 and first_rollpoint_array[frame] != 10
      print "spare!!!!\n"
      wait_key = gets.chomp
    end
end

class Score


  attr_accessor :firstpoint
  attr_accessor :secondpoint
  attr_accessor :display_totalscore
  attr_accessor :display_firstpoint
  attr_accessor :display_secondpoint

  def initialize
    @firstpoint = Array.new(12)
    @secondpoint = Array.new(11)
    @display_totalscore = Array.new(10)
    @display_firstpoint = Array.new(11) #[2,0,3,10,6,4,3,7,0,6,10]
    @display_secondpoint =  Array.new(11)#[0,1,7,0,4,4,7,7,0,4,3]
    @turn = 0
    @totalscore = 0
   # @firstpoint = [0,0,0,0,0,0,0,0,0,0,0]
   # @secondpoint = [0,0,0,0,0,0,0,0,0,0,0]
  end

  def first_roll(first_rollpoint_array, frame)
      print "Input a number of first point of ", frame+1, " frame between 0 and 10.  \n"
      first_rollpoint_array[frame] = gets.chomp.to_i  
  end


  def second_roll(first_rollpoint_array, second_rollpoint_array, frame)
    print "Input a number of second point of ", frame+1, " frame between 0 and ", 10 - first_rollpoint_array[frame],".  \n"
    
    second_rollpoint_array[frame] = gets.chomp.to_i

    validate_gutter(second_rollpoint_array, frame)
    
    validate_spare(first_rollpoint_array, second_rollpoint_array, frame)

    if second_rollpoint_array[frame] + first_rollpoint_array[frame] > 10 
      print "Error!!! over 10 points. input 0.\n"
      second_rollpoint_array[frame] = 0
      wait_key = gets.chomp
    end
    validate_low0_high10( second_rollpoint_array, frame )
  end

  def case_10frame_strike(first_rollpoint_array, second_rollpoint_array)
    if first_rollpoint_array[9] == 10
      print "Input a number of first roll point of last frame between 0 and 10.  \n"
      first_rollpoint_array[10] = gets.chomp.to_i
      validate_low0_high10( first_rollpoint_array, 10 )
      if first_rollpoint_array[10] == 10
        print "Input a number of second roll point of last frame between 0 and 10.  \n"
        first_rollpoint_array[11] = gets.chomp.to_i
        validate_low0_high10( first_rollpoint_array, 11 )
      else
        print "Input a number of second roll point of last frame between 0 and 10.  \n"
        second_rollpoint_array[10] = gets.chomp.to_i
        validate_low0_high10(second_rollpoint_array, 10)
      end
    end
  end

  def case_10frame_spare(first_rollpoint_array, second_rollpoint_array)
    if first_rollpoint_array[9] + second_rollpoint_array[9] == 10 and  first_rollpoint_array[9] != 10
      print "Input a number of last raoll point between 0 and 10.  \n"
      first_rollpoint_array[10] = gets.chomp.to_i
      validate_low0_high10(first_rollpoint_array, 10)
    end
  end

  def input  #input score

    for i in 0..9
      @turn = i + 1
 
      first_roll(@firstpoint, i)

      validate_gutter(@firstpoint, i)
      validate_strike(@firstpoint, i)
      validate_low0_high10( @firstpoint, i )

      if @firstpoint[i] == 10
        @secondpoint[i] = 0
      else
        self.second_roll(@firstpoint, @secondpoint, i)
      end
      self.calcuration(i)
      self.display2(i)
      #self.display(i)
      
    end #for_end

    self.case_10frame_strike(@firstpoint, @secondpoint)
    self.case_10frame_spare(@firstpoint, @secondpoint)
  end

  def cal_case_strike(frame)
    if  @firstpoint[frame] == 10
      @display_firstpoint[frame] = "X"
      @display_secondpoint[frame] = " "
      if  @firstpoint[frame+1] == nil
        @display_totalscore[frame] = " "
        
      elsif @firstpoint[frame+1] == 10 and @firstpoint[frame+2] == nil
        @display_totalscore[frame] = " "
      elsif  @firstpoint[frame+1] == 10 and @firstpoint[frame+2] != nil
        @display_totalscore[frame] = @totalscore + 20 + @firstpoint[frame+2]
        @totalscore += 20 + @firstpoint[frame+2]
      else
        @display_totalscore[frame] = @totalscore + 10 + @firstpoint[frame+1] + @secondpoint[frame+1]
        @totalscore += 10 + @firstpoint[frame+1] + @secondpoint[frame+1]
      end
    else
      return false
    end
  end

  def cal_case_spare(frame)
     if  @firstpoint[frame] + @secondpoint[frame] == 10  and @firstpoint[frame] != 10
        @display_firstpoint[frame] = @firstpoint[frame]
        @display_secondpoint[frame] = "/"
        if  @firstpoint[frame+1] == nil
          @display_totalscore[frame] = " "
        else
          @display_totalscore[frame] = @totalscore + 10 + @firstpoint[frame+1]
          @totalscore += 10 + @firstpoint[frame+1]
          print frame,"  ", @totalscore," spare,OK\n"
        end
     else
       return false
     end
  end
  def cal_case_10frame_strike
    if @firstpoint[9] == 10 
      if @firstpoint[10] == 10
        @display_firstpoint[10] = "X"
      else
        @display_firstpoint[10] =  @firstpoint[10]
        @display_secondpoint[10] =  @secondpoint[10]
      end
      if @firstpoint[11] == 10
        @display_firstpoint[11] = "X"
      else
        @display_firstpoint[11] =  @firstpoint[11]
      end
    else
      return false
    end
  end
  
  def cal_case_10frame_spare
    if  @firstpoint[9] + @secondpoint[9] == 10 and  @firstpoint[9] != 10
      if  @firstpoint[10] == 10
        @display_firstpoint[10] = "X"
      else
        @display_firstpoint[10] =  @firstpoint[10]
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
        @display_firstpoint[i] = @firstpoint[i]
        @display_secondpoint[i] =  @secondpoint[i]
        @display_totalscore[i] = @totalscore + @firstpoint[i] + @secondpoint[i]
        @totalscore += @firstpoint[i] + @secondpoint[i]
      end
    end #for end
  end

  def display2(frame) 
    for i in 0..frame
      
      if i == 9 
        if @firstpoint[9] == 10 and @firstpoint[10] == 10
          print "   ", @display_firstpoint[i], "  ", @display_firstpoint[i+1], " ", @display_firstpoint[i+2], "|"
        elsif  @firstpoint[9] == 10
          print "   ", @display_firstpoint[i], "  ", @display_firstpoint[i+1], " ", @display_secondpoint[i+1], "|"
        elsif @firstpoint[9] +  @secondpoint[9] == 10
          print "   ", @display_firstpoint[i], "  ", @display_secondpoint[i], " ", @display_firstpoint[i+1], "|"
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
        if  @firstpoint[9] +  @secondpoint[9] == 10
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

bob.input
#bob.firstpoint = [10,10,10,10,10,10,10,10,10,10,10,10,10]
#bob.secondpoint = [0,0,0,0,0,0,0,0,0,0,0]
bob.calcuration(9)
#print bob.display_totalscore[9]
bob.display2(9)
