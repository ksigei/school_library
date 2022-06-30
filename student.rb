require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(name = 'Unknown', classroom = 'Unknown', parent_permission: true)
    super(name, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
