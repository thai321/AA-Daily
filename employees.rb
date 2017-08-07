require 'byebug'

class Employee
  attr_reader :salary, :name

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary

    change_boss(boss) if !boss.nil?
  end

  def change_boss(new_boss)
    @boss = new_boss
    @boss.employees << self
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss = nil)
    super(name, title, salary, boss)
    @employees = []
  end

  def bonus(multiplier)
    total_salary * multiplier
  end

  protected

  def total_salary
    total = 0
    @employees.each do |employee|
      if employee.is_a?(Manager)
        puts "#{employee.name} salary: #{employee.salary}"
        total += employee.salary + employee.total_salary
      else
        total += employee.salary
      end
    end

    total
  end
end



if __FILE__ == $0

  ned = Manager.new("Ned", "Founder", 1000000)
  darren = Manager.new("Daren", "TA Manager", 78000, ned)
  shawna = Employee.new("Shawna","TA", 12000, darren)
  david = Employee.new("David","TA", 10000, darren)

  p ned.bonus(5)
  p darren.bonus(4)
  p david.bonus(3)
  # puts darren.salary
end
