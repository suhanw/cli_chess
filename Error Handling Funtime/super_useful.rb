# PHASE 2
def convert_to_int(str)
  Integer(str)
  rescue ArgumentError => e
    return nil
  # end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise StandardError.new('This is NOT a fruit! But thanks for the coffee!')
  else
    raise StandardError.new('This is NOT a fruit!')
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue StandardError => e
    puts e.message
    retry if maybe_fruit == "coffee"
  end
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    if yrs_known < 1
      raise ArgumentError.new("You have to know each other more than one year!")
    end
    if name.length <= 0
      raise ArgumentError.new("Please enter your best friend's name!")
    end
    if fav_pastime.length <= 0
      raise ArgumentError.new("Please share your favorite pasttime!")
    end

    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime

  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
