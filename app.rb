require './book'
require './person'
require './teacher'
require './student'
require './rental'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_books
    @books.each do |book|
      puts book.title
    end
  end

  def list_people
    @people.each do |person|
      puts person.name
    end
  end

  def create_person(name, type)
    case type
    when 'teacher'
      @people << Teacher.new(name)
    when 'student'
      @people << Student.new(name)
    end
  end

  def create_book(title)
    @books << Book.new(title)
  end

  def create_rental(person_id, book_id, date)
    @rentals << Rental.new(date, @books[book_id], @people[person_id])
  end

  def list_rentals(person_id)
    @rentals.each do |rental|
      puts rental.date if rental.person.id == person_id
    end
  end
end

app = App.new
app.create_person('John', 'teacher')
app.create_person('Mary', 'student')
app.create_book('Harry Potter')
app.create_rental(0, 0, '2018-01-01')
app.list_rentals(0)
