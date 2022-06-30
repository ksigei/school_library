require_relative 'person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(name = 'Unknown', specialization = 'Unknown', parent_permission: true)
    super(name, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
