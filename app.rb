require 'json'
require './classroom'
require './person'
require './teacher'
require './student'
require './book'
require './rental'
require './utils'

class App
  attr_accessor :user_input

  def initialize
    puts 'Welcome to School Library App!'
    Utils.print_prompt
    @user_input = gets.chomp
    @default_classroom = Classroom.new('default-classroom')
    @people = []
    @books = []
    @rentals = []
  end

  def user_input_valid?(user_input, arr)
    arr.include?(user_input)
  end

  def student_info
    age = Utils.read_age
    name = Utils.read_name
    has_parent_permission = Utils.read_permission == 'Y'
    [age, name, has_parent_permission]
  end

  def teacher_info
    age = Utils.read_age
    name = Utils.read_name
    specialization = Utils.read_specialization
    [age, name, specialization]
  end

  def create_person
    print "\nDo you want to create a student (1) or a teacher (2)? [Input the number]: "
    @user_input = gets.chomp
    create_person unless user_input_valid?(@user_input, %w[1 2])
    if @user_input == '1'
      age, name, has_parent_permission = student_info
      person = Student.new(age, @default_classroom, name, parent_permission: has_parent_permission)
    else
      age, name, specialization = teacher_info
      person = Teacher.new(age, specialization, name)
    end
    @people << person
    File.open('./data/people.json', 'a') do |file|
      file.puts person.to_json
    end
    puts 'Person created successfully'
  end

  def read_title
    print 'Title: '
    title = gets.chomp
    title.empty? ? read_title : title
  end

  def read_author
    print 'Author: '
    author = gets.chomp
    author.empty? ? read_author : author
  end

  def create_book
    title = read_title
    author = read_author
    book = Book.new(title, author)
    @books << book
    File.open('./data/books.json', 'a') do |file|
      file.puts book.to_json
    end
    puts 'Book created successfully'
  end

  def list_all_books
    @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: \"#{book.author}\"" }
  end

  def list_all_people
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def read_desired_book
    puts "\nSelect a book from the following list by number"
    list_all_books
    desired_book_index = gets.chomp
    (0...@books.length).include?(desired_book_index.to_i) ? desired_book_index.to_i : read_desired_book
  end

  def read_desired_person
    puts "\nSelect a person from the following list by number"
    list_all_people
    desired_person_index = gets.chomp
    (0...@people.length).include?(desired_person_index.to_i) ? desired_person_index.to_i : read_desired_person
  end

  def read_desired_date
    print "\nDate: "
    gets.chomp
  end

  def create_rental
    return print 'Please add a book first' if @books.empty?
    return print 'Please add a person first' if @people.empty?

    book = @books[read_desired_book]
    person = @people[read_desired_person]
    date = read_desired_date

    rental = Rental.new(date, person, book)

    @rentals << rental
    File.open('./data/rentals.json', 'a') do |file|
      file.puts rental.to_json
    end
    puts 'Rental created successfully'
  end

  def create_for_user(user_input)
    case user_input
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    end
  end

  def list_all_rentals_for_id
    return puts 'Please add a rental first' if @rentals.empty?

    puts "\nSelect a person from the following list by number"
    @people.each do |person|
      puts "ID: #{person.id}, [#{person.class}] Name: #{person.name}, Age: #{person.age}"
    end
    person_id = gets.chomp.to_i
    rental_list = @rentals.select { |rental| rental.person.id == person_id }
    if rental_list.empty?
      puts 'No rentals found for this person.'
    else
      rental_list.each do |rental|
        puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by  #{rental.book.author}"
      end
    end
  end

  def display_for_user(user_input)
    case user_input
    when '1'
      list_all_books
    when '2'
      list_all_people
    when '6'
      list_all_rentals_for_id
    end
  end

  def run
    loop do
      case user_input
      when '10', '2', '6'
        display_for_user(user_input)
      when '3', '4', '5'
        create_for_user(user_input)
      when '7'
        puts 'Thank you for using this app!'
        exit(true)
      else
        puts "\nInvalid input \"#{user_input}\"!"
        puts 'please try with one of these options:'
        Utils.print_prompt
        @user_input = gets.chomp
        run
      end
      Utils.print_prompt
      @user_input = gets.chomp
    end
  end
end

def main
  app = App.new
  app.run
end

main
