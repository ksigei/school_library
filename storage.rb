require 'json'
require_relative './person'
# add_person(person).
# read_person.
# convert_json_to_person.
# convert_person_to_json.
# save_person.
def add_person(person)
  puts 'What is the name of the person?'
  print '> '
  name = gets.chomp
  puts 'What type of person is this? (teacher/student)'
  print '> '
  type = gets.chomp
  person.name = name
  person.type = type
  person
end
def add_person(person)
    File.open('person.json', 'a') do |f|
      f.puts person.to_json
    end
  end
  
  def read_person
    File.read('person.json')
  end
  
  def convert_json_to_person(json)
    JSON.parse(json)
  end
  
  def convert_person_to_json(person)
    person.to_json
  end
  def save_person(person)
    File.open('person.json', 'w') do |f|
      f.puts person.to_json
    end
  end
  



