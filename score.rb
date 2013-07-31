def validate_low0_high10(rollpoint_array, frame)
     if rollpoint_array[frame] < 0 or rollpoint_array[frame] > 10
       print "Error!!! A number should be inputed between 0 and 10. point is 0.\n"
       rollpoint_array[frame] = 0
       wait_key = gets.chomp
     end
end

def validate_gutter(rollpoint_array, frame)
      if rollpoint_array[frame] == 0
        print "Gutter!!!\n"
        wait_key = gets.chomp
      end
end

def validate_strike(rollpoint_array, frame)
      if rollpoint_array[frame] == 10 and rollpoint_array[frame-1] == 10
          print "Double!!!!!!\n"
          wait_key = gets.chomp
      elsif rollpoint_array[frame] == 10
          print "Strike!!!!\n"
          wait_key = gets.chomp
      else
      end
end

class Score
  def initialize
    @firstpoint = Array.new(12)
    @secondpoint = Array.new(11)
    @turn = 0
   # @firstpoint = [0,0,0,0,0,0,0,0,0,0,0]
   # @secondpoint = [0,0,0,0,0,0,0,0,0,0,0]


  end
  attr_accessor :firstpoint
  attr_accessor :secondpoint

  def first_roll(first_rollpoint_array, frame)
      print "Input a number of first point of ", frame+1, " frame between 0 and 10.  \n"
      first_rollpoint_array[frame] = gets.chomp.to_i  
  end


  def second_roll(first_rollpoint_array, second_rollpoint_array, frame)
    print "Input a number of second point of ", frame+1, " frame between 0 and ", 10 - first_rollpoint_array[frame],".  \n"
    
    second_rollpoint_array[frame] = gets.chomp.to_i

    validate_gutter(second_rollpoint_array, frame)
    
    if second_rollpoint_array[frame] + first_rollpoint_array[frame] == 10
      print "spare!!!!\n"
      wait_key = gets.chomp
    elsif second_rollpoint_array[frame] + first_rollpoint_array[frame] > 10
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


  def calcuration(frame)
    
    @display_firstpoint = [2,0,3,10,6,4,3,7,0,6,10]
    @display_secondpoint = [0,1,7,0,4,4,7,7,0,4,3]
    @display_totalscore = [0,1,7,0,4,4,7,7,0,4,3]
    totalscore = 0
    
    if frame == 9
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
      elsif  @firstpoint[9] + @secondpoint[9] == 10 
        if  @firstpoint[10] == 10
          @display_firstpoint[10] = "X"
        else
          @display_firstpoint[10] =  @firstpoint[10]
        end
      end
    end

    for i in 0..frame
      if  @firstpoint[i] == 10
        @display_firstpoint[i] = "X"
        @display_secondpoint[i] = " "
        if  @firstpoint[i+1] == nil
          @display_totalscore[i] = " "
          
        elsif @firstpoint[i+1] == 10 and @firstpoint[i+2] == nil
          @display_totalscore[i] = " "
        elsif  @firstpoint[i+1] == 10
          @display_totalscore[i] = totalscore + 20 + @firstpoint[i+2]
          totalscore += 20 + @firstpoint[i+2]
        else
          @display_totalscore[i] = totalscore + 10 + @firstpoint[i+1] + @secondpoint[i+1]
          totalscore += 10 + @firstpoint[i+1] + @secondpoint[i+1]
        end
      elsif  @firstpoint[i] + @secondpoint[i] == 10
        @display_firstpoint[i] = @firstpoint[i]
        @display_secondpoint[i] = "/"
        if  @firstpoint[i+1] == nil
          @display_totalscore[i] = " "
        else
          @display_totalscore[i] = totalscore + 10 + @firstpoint[i+1]
          totalscore += 10 + @firstpoint[i+1]
        end
      else

        @display_firstpoint[i] = @firstpoint[i]
        @display_secondpoint[i] =  @secondpoint[i]
        @display_totalscore[i] = totalscore + @firstpoint[i] + @secondpoint[i]
        totalscore += @firstpoint[i] + @secondpoint[i]
      end
      print @firstpoint[i],"  ",  @secondpoint[i],"  ",totalscore, "\n"
      #totalscore += @firstpoint[i] + @secondpoint[i]
      print "after  ",  @secondpoint[i],"  ",totalscore, "\n"
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


  def display(frame)  #display score

    #@firstpoint = [2,0,3,10,6,4,3,7,0,6,10]
    #@secondpoint = [0,1,7,0,4,4,7,7,0,4,3]
    
    total = 0
    bonus = [0,0,0,0,0,0,0,0,0,0,0]
    print "your score \n"
    for i in 0..frame
      tmpfp = @firstpoint[i] 
      tmpsp = @secondpoint[i]
      lfp = @firstpoint[i+1]
      lsp = @secondpoint[i+1]
      if lfp == 10
        lfp = "X"
        lsp = " "
      elsif @firstpoint[i+1] + @firstpoint[i+1] == 10
     
        lsp = "/"
      end

      if @firstpoint[i] == 10
        tmpfp = "X"
        tmpsp = " "
        if @firstpoint[i+1] == 10
          bonus[i] = @firstpoint[i+1] + @firstpoint[i+2]
        else
          bonus[i] = @firstpoint[i+1] + @secondpoint[i+1]
        end
      elsif @firstpoint[i] + @secondpoint[i] == 10
        tmpsp = "/"
        bonus[i] = @firstpoint[i+1]
      end
      
      if i == 9 
        if @firstpoint[9] == 10 and @firstpoint[10] == 10 and  @firstpoint[11] == 10
          print "   ", tmpfp, "  ", lfp, " X|"
        elsif @firstpoint[i] == 10
          print "   ", tmpfp, "  ", lfp, " ", lsp, "|"
        elsif @firstpoint[i] + @secondpoint[i] == 10
          print "   ", tmpfp, " ", tmpsp, "  ", lfp, "|"
        else
          print "   ", tmpfp, " ", tmpsp, "|"
        end
      else
        print "   ", tmpfp, " ", tmpsp, "|"
      end
    end
    print "\n"


    
    for i in 0..frame
      total = total + @firstpoint[i] + @secondpoint[i] + bonus[i]
      
      if i == 9 
        if @firstpoint[i] + @secondpoint[i] == 10
          print "   ", "%6d" % total , "|"
        else
          print "   ", "%3d" % total , "|"
        end

      else
        if i == frame-1 and @firstpoint[frame-1]==10 and  @firstpoint[frame]==10
          print "      |"
 
        elsif i == frame and  @firstpoint[i] + @secondpoint[i] == 10
          print "      |"
        else
          print "   ", "%3d" % total , "|"
        end
      end
    end
    
    print "\n"
    print " X : strike\n / : spare\n"

  end

end # class end

bob = Score.new

bob.input
bob.calcuration(9)
bob.display2(9)
