require './score'

input_ken = Input.new



input_ken.input

#input_ken.down_pins_first_roll = [10,10,10,10,10,10,10,10,10,3,3,3]
#input_ken.down_pins_second_roll = [0,0,0,0,0,0,0,0,0,7,3]
ken = Calcuration.new(input_ken.down_pins_first_roll, input_ken.down_pins_second_roll)
ken.calcuration(9)
#print ken.totalscores[9]
ken = Display.new(input_ken.down_pins_first_roll, input_ken.down_pins_second_roll, ken.first_points, ken.second_points, ken.totalscores)
ken.display2(9)
