class Employee

  def initialize(name, title, salary, boss=nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end
end

class Manager < Employee

  def initialize
    @subordinates = []
    super
  end

  def bonus(multiplier)
    subordinate_salaries = @subordinates.map { |employee| employee.salary }
    subordinate_total = subordinate_salaries.reduce(:+)
    bonus = subordinate_total * multiplier
  end
end
