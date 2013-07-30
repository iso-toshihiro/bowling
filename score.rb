
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
    @firstpoint = Array.new
    @secondpoint = Array.new
    @turn = 0
 
  end
  attr_accessor :firstpoint
  attr_accessor :secondpoint


  def ten_frame_strike(first_rollpoint_array, second_rollpoint_array)
    if first_rollpoint_array[9] == 10
      print "Input a number of first point of last frame between 0 and 10.  \n"
      first_rollpoint_array[10] = gets.chomp.to_i
      validate_low0_high10( first_rollpoint_array, 10 )
      if first_rollpoint_array[10] == 10
        print "Input a number of second point of last frame between 0 and 10.  \n"
        first_rollpoint_array[11] = gets.chomp.to_i
        validate_low0_high10( first_rollpoint_array, 11 )
      else
        print "Input a number of second point of last frame between 0 and 10.  \n"
        second_rollpoint_array[10] = gets.chomp.to_i
        validate_low0_high10(second_rollpoint_array, 10)
      end
    end
  end






  def input  #input score
    #firstpoint = Array.new
    #secondpoint = Array.new
    #i = 0 

    @firstpoint[10] = 0
    @firstpoint[11] = 0
    @secondpoint[10] = 0

    for i in 0..9
      @turn = i + 1
      print "Input a number of first point of frame ", @turn, " between 0 and 10.  \n"
      @firstpoint[i] = gets.chomp.to_i  

      validate_gutter(@firstpoint, i)
      validate_strike(@firstpoint, i)
      validate_low0_high10( @firstpoint, i )

      if @firstpoint[i] == 10
        @secondpoint[i] = 0
      else
        print "Input a number of second point of frame ", @turn, " between 0 and ", 10 - @firstpoint[i],".  \n"
        
        @secondpoint[i] = gets.chomp.to_i

        validate_gutter(@secondpoint, i)

        if @secondpoint[i] + @firstpoint[i] == 10
          print "spare!!!!\n"
          wait_key = gets.chomp
        elsif @secondpoint[i] + @firstpoint[i] > 10
          print "Error!!! over 10 points. input 0.\n"
          @secondpoint[i] = 0
          wait_key = gets.chomp
        end
        validate_low0_high10( @secondpoint, i )

      end
      print "your score of frame ", @turn, ".\n"
      
      print @firstpoint[i], "  ", @secondpoint[i], "\n"
      
    end #for_end
=begin
    if @firstpoint[9] == 10
      print "Input a number of first point of last turn between 0 and 10.  \n"
      @firstpoint[10] = gets.chomp.to_i
      low0_high10( @firstpoint, 10 )
      if @firstpoint[10] == 10
        print "Input a number of second point of last turn between 0 and 10.  \n"
        @firstpoint[11] = gets.chomp.to_i
        low0_high10( @firstpoint, 11 )
      else
        print "Input a number of second point of last frame between 0 and 10.  \n"
        @secondpoint[10] = gets.chomp.to_i
        low0_high10(@secondpoint, 10)
      end
    end
=end

    self.ten_frame_strike(@firstpoint, @secondpoint)

    if @firstpoint[9] + @secondpoint[9] == 10 and  @firstpoint[9] != 10
      print "Input a number of last point between 0 and 10.  \n"
      @firstpoint[10] = gets.chomp.to_i
      validate_low0_high10(@firstpoint, 10)
    end

  end


  def display  #display score

    #@firstpoint = [2,0,3,10,6,4,3,7,0,6,10]
    #@secondpoint = [0,1,7,0,4,4,7,7,0,4,3]
    
    total = 0
    bonus = [0,0,0,0,0,0,0,0,0,0,0]
    print "your score \n"
    for i in 0..9
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
        if @firstpoint[i] == 10
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
    for i in 0..9
      total = total + @firstpoint[i] + @secondpoint[i] + bonus[i]
      
      if i == 9 and @firstpoint[i] + @secondpoint[i] == 10
        print "   ", "%6d" % total , "|"
      else
        print "   ", "%3d" % total , "|"
      end
    end
    
    print "\n"
    print " X : strike\n / : spare\n"

  end

end # class end

bob = Score.new

bob.input
bob.display
