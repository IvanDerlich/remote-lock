class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    puts "----Begining" 
    people = []

    dollar_people = process_dollar @params[:dollar_format].lines[1..-1]
    people.push(dollar_people)

    percent_people = process_percent @params[:percent_format].lines[1..-1]
    people.push(percent_people)

    people = sort people.flatten
    
    compose people
  end

  private

  def process_dollar text_array    
    cities = {
      'NYC': 'New York City',
      'LA': 'Los Angeles'
    }    
    text_array.map do |input|
      splitted = input.split(' $ ')
      splitted_birthdate = splitted[1].split('-')
      {
        name: splitted[3][0...-1],
        city: cities[splitted[0].to_sym],
        day: splitted_birthdate[0].to_i,
        month: splitted_birthdate[1].to_i,
        year: splitted_birthdate[2].to_i,
      }
    end
  end

  def process_percent text_array
    output = text_array.map do |input|
      splitted = input.split(' % ')
      splitted_birthdate = splitted[2].split('-')
      p splitted[2]
      p splitted_birthdate
      {
        name: splitted[0],
        city: splitted[1],      
        day: splitted_birthdate[2][0...-1].to_i,
        month: splitted_birthdate[1].to_i,
        year: splitted_birthdate[0].to_i,
      }
    end
  end

  def sort input
    input.sort_by do |input|
       input[:name] 
    end
  end  

  def compose people
    output = people.map do |element|
      "#{element[:name]}, #{element[:city]}, #{element[:month]}/#{element[:day]}/#{element[:year]}"
    end
  end

  attr_reader :params
end
