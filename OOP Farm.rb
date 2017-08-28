class Field

  @@current_fields = {}
  @@total_food_by_crop = {}
  @@food_per_area_values = {
    corn: 20,
    wheat: 30,
    potatoes: 25,
    spinach: 40,
    onion: 17,
    tomatoes: 30
  }

  attr_reader :crop_type, :food_per_area, :crop_area

  def initialize(crop_type, crop_area)
    @crop_type = crop_type
    @crop_area = crop_area
    @food_per_area = @@food_per_area_values[crop_type] ? @@food_per_area_values[crop_type] : 20
  end

  def plant(crop_type, food_per_area, crop_area)
    new_field = Field.new(crop_type, food_per_area, crop_area)
    if @@current_fields[new_field.crop_type].to_i > 0
       @@current_fields[new_field.crop_type] += new_field.crop_type
    else
      @@current_fields[new_field.crop_type] = new_field.crop_area
    end
  end

  def harvest
    @@all_fields.each do |each_field|
      if @@total_food_by_crop[each_field.crop_type] != nil
        @@total_food_by_crop[each_field.crop_type] = each_field.food_per_area * each_field.crop_area
      else
        @@total_food_by_crop[each_field.crop_type] += each_field.food_per_area * each_field.crop_area
      end
        puts "Total #{each_field.crop_type} ever harvested: #{@@total_food_by_crop[each_field.crop_type]}"
        @@current_fields = []
      end
        puts "Total food ever harvested, of all crop types, is #{@@total_food_by_crop.values.sum}."
  end

  def relax
    quotes = [
      "You gaze out into the expanse of crops that you've raised. The sun sits low in the sky. You are content.",
      "It's a rainy day. You decide to curl up by the fireplace with the pup. It's pleasantly warm.",
      "Hey. Screw it. You've been working hard. You deserve to put your feet up and have a beer today."
    ]
      puts quotes.sample
  end

  def check_field
    puts "Which field do you want to check? Pick an option or enter 'x' to do something else."
    total_food_by_crop.keys.each do |each_crop|
    puts "#{each_crop.crop_type}"
  end
    which_crop = gets.chomp
    case which_crop.to_i
  when 0
      farmer_menu
    when 1..total_food_by_crop.keys.length
      puts "You look at your field of #{current_fields.[which_crop]}"
    else
      puts which_crop.to_i
      puts "Invalid entry!"
    end
  end

  def self.farmer_menu
    while true
      puts "Good morning! What would you like to do today?"
      puts "[1] Plant a crop."
      puts "[2] Harvest all crops."
      puts "[3] Relax."
      puts "[4] Check a field."
      user_input = gets.chomp
      read_input(user_input)
    end
  end

  def read_input(user_input)
    if user_input > 0
      case user_input
      when 1
        plant
      when 2
      when 3
      when 4
      end
    else
      puts "Invalid entry!"
    end
  end
end

Field.new

end
