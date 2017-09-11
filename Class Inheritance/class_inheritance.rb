class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
    @boss = nil
  end

  def add_boss(boss)
    @boss = boss
    @boss.employees << self
  end

  def bonus(multiplier)
    self.salary * multiplier
  end
end

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary)
    @employees = []

    super(name, title, salary)
  end

  def bonus(multiplier)
    total_subsalaries(self.employees) * multiplier
  end

  def total_subsalaries(employees)
    subsalaries_sum = 0

    # Create a queue, add the current node (employee)
    q = employees
    # Until array is empty,
    until q.empty?
      # add up the salary of the employees in queue
      subsalaries_sum += q.first.salary
      # Add the current employee's children to the queue AND we remove current employee
      current_employee = q.shift
      q += current_employee.employees if current_employee.is_a?(Manager)
    end

    subsalaries_sum
  end
end

if __FILE__ == $PROGRAM_NAME
  david = Employee.new('David', 'TA', 10000)
  shawna = Employee.new('Shawna', 'TA', 12000)
  darren = Manager.new('Darren', 'TA Manager', 78000)
  david.add_boss(darren)
  shawna.add_boss(darren)
  ned = Manager.new('Ned', 'Founder', 1000000)
  darren.add_boss(ned)
  p ned.bonus(5)
  p darren.bonus(4)
  p david.bonus(3)
end
