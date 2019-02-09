class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    new_student = self.new 
    new_student.id = row[0]
    new_student.name = row [1]
    new_student.grade = row[2]
    new_student
    # create a new Student object given a row from the database
  end

  def self.all
    sql = 
    "SELECT *
    FROM students" 
     
    
    DB[:conn].execute(sql).collect do |row|
      self.new_from_db(row)   
    end 
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
  end

  def self.find_by_name(name)
    sql =
      "SELECT *
      FROM students 
      WHERE name = ?
      LIMIT 1"
      
    
    DB[:conn].execute(sql,name).map do |row|
      self.new_from_db(row)
    end.first
    # find the student in the database given a name
    # return a new instance of the Student class
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
  
  def self.all_students_in_grade_9 
    sql = "SELECT * FROM students WHERE students.grade = 9"
    DB[:conn].execute(sql).collect do |row|
      self.new_from_db(row)
    end
  end 

  def self.students_below_12th_grade
    sql = "SELECT * FROM students WHERE students.grade < 12"
    
    DB[:conn].execute(sql).collect do |row|
      self.new_from_db(row)
    end 
  end 
  
  def self.first_X_students_in_grade_10(x)
    sql = "SELECT * FROM students WHERE students.grade = 10 LIMIT ?"
    
    DB[:conn].execute(sql, x)
  end 
  
  def self.first_student_in_grade_10 
    sql = "SELECT * FROM students WHERE students.grade = 10 LIMIT 1"
    
    first_student = DB[:conn].execute(sql)[0]
    self.new_from_db(first_student)
    end 
  end 
  
  def self.all_students_in_grade_X
  end 
end
