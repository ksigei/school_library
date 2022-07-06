module Utils
  def self.print_prompt
    puts '
              Please choose an option by entering a number:
              1 | List all books
              2 | List all people
              3 | Create a person
              4 | Create a book
              5 | Create a rental
              6 | List all rentals for a given person id
              7 | Exit'
    puts ''
    puts 'Select an option: '
  end

  def self.read_name
    print 'Name: '
    name = gets.chomp
    name.empty? ? read_name : name
  end

  def self.read_age
    print 'Age: '
    age = gets.chomp.to_i
    (1..1000).include?(age) ? age : read_age
  end

  def self.read_permission
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    %w[Y N].include?(permission.capitalize) ? permission.capitalize : read_permission
  end

  def self.read_specialization
    print 'Specialization: '
    specialization = gets.chomp
    specialization.empty? ? read_specialization : specialization
  end
  # create and add to corresponding json files
  # def self.create_person(name, type)
  #   person = Person.new(name, type)
  #   File.open("./data/people.json", "a") do |file|
  #     file.puts person.to_json
  #   end
  # end

  # def self.create_book(title)
  #   book = Book.new(title)
  #   File.open("./data/books.json", "a") do |file|
  #     file.puts book.to_json
  #   end
  # end

  # def self.create_rental(person_id, book_id, date)
  #   rental = Rental.new(date, person_id, book_id)
  #   File.open("./data/rentals.json", "a") do |file|
  #     file.puts rental.to_json
  #   end
  # end

  # def self.list_books
  #   books = File.read("./data/books.json")
  #   books = JSON.parse(books)
  #   books.each do |book|
  #     puts "ID: #{book["id"]}, [#{book["class"]}] Title: #{book["title"]}, Author: #{book["author"]}"
  #   end
  # end

  # def self.list_people
  #   people = File.read("./data/people.json")
  #   people = JSON.parse(people)
  #   people.each do |person|
  #     puts "ID: #{person["id"]}, [#{person["class"]}] Name: #{person["name"]}, Age: #{person["age"]}"
  #   end
  # end

  # def self.list_rentals(person_id)
  #   rentals = File.read("./data/rentals.json")
  #   rentals = JSON.parse(rentals)
  #   rentals.each do |rental|
  #     if rental["person_id"] == person_id
  #       puts "Date: #{rental["date"]}, Book: \"#{rental["book"]["title"]}\" by  #{rental["book"]["author"]}"
  #     end
  #   end
  # end
end
