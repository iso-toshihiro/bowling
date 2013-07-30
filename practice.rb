class Name

  Version = "1.0"
  @@mind = "2.0"

  def initialize ( myname = " toshi" )
    @name = myname
  end

  #attr_reader :name
  def self.yey
    @@mind
  end

  def hello 
    print @name
    return @name
  end

  def rename ( rename= "toshi" )
    @name = rename
  end
  
  def greet
    print "Hi, I am ", self.name, ".\n"
  end

  def prime?(num = 0)
    if num < 3 
      return nil
    end
    2.upto(num-1) do |i|
      c = num % i
      if c == 0
        return "no"
      end
    end
    print num, "\n"
    return "yes"
  end

  def dice
    print rand(6)+1, "\n"
  end

end

bob = Name.new ("bob")
ken = Name.new ("ken")

p bob.prime?(4)
p bob.prime?(5)
p bob.prime?(3)

10.times do |i|

bob.dice

end

=begin
#bob.hello

p bob.hello
ken.hello
p ken.hello
#ken.rename( ken.name )

p Name::Version
p Name::yey

#ken.greet
#bob.greet
#print bob.name
=end
