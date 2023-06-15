import Foundation

final class Main {
    private init() {
        fatalError("Utility class")
    }

    // Main entry point of the program
    static func main() {
        do {
            // Read input from file
            let input = try String(contentsOfFile: "Input.txt", encoding: .utf8)
            let fileList = input.components(separatedBy: "\n")
            
            // Create math and physics courses
            let mathCourse = Course(name: fileList[0])
            let physicsCourse = Course(name: fileList[1])
            
            // Create student1 and student2
            let student1 = Student(name: fileList[2], id: 1)
            let student2 = Student(name: fileList[5], id: 2)
            
            // Enroll student1 in math and physics courses
            student1.enrollCourse(course: mathCourse)
            student1.enrollCourse(course: physicsCourse)
            
            // Enroll student2 in physics and math courses
            student2.enrollCourse(course: physicsCourse)
            student2.enrollCourse(course: mathCourse)
            
            // Record grades for student1
            recordGrades(student: student1, inputs: fileList, counter: 3)
            
            // Record grades for student2
            recordGrades(student: student2, inputs: fileList, counter: 6)
            
            // Print student1's name and GPA
            print("\(student1.getName())'s GPA: \(student1.calculateGpa())")
            
            // Print student2's name and GPA
            print("\(student2.getName())'s GPA: \(student2.calculateGpa())")
            
            // Print the average grade for the math course
            print("Math course average: \(mathCourse.getCourseAverageGrade())")
            
            // Print the average grade for the physics course
            print("Physics course average: \(physicsCourse.getCourseAverageGrade())")
        } catch {
            print("No file found")
        }
    }

    // Record grades for a student based on the input data
    static func recordGrades(student: Student, inputs: [String], counter: Int) {
        var _counter = counter
        for course in student.courses {
            if let grade = Double(inputs[_counter]) {
                student.setGrade(course: course, grade: grade)
            }
            _counter += 1
        }
    }
}

final class Course: Equatable {
    private let name: String
    private var students: [Student]

    init(name: String) {
        self.name = name
        self.students = []
    }

    // Enroll a student in the course
    func enrollStudent(student: Student) {
        students.append(student)
    }

    // Record a grade for a student in the course
    func recordGrade(student: Student, grade: Double) {
        student.setGrade(course: self, grade: grade)
    }

    // Calculate the average grade for the course
    func getCourseAverageGrade() -> Double {
        var sum = 0.0
        for student in students {
            if let grade = student.getGrade(course: self) {
                sum += grade
            }
        }
        return sum / Double(students.count)
    }

    // Get the name of the course
    func getName() -> String {
        return name
    }

    static func == (lhs: Course, rhs: Course) -> Bool {
        return lhs.name == rhs.name
    }
}

final class Student {
    private let name: String
    private let id: Int
    var courses: [Course]
    private var grades: [Double]

    init(name: String, id: Int) {
        self.name = name
        self.id = id
        self.courses = []
        self.grades = []
    }

    // Set the grade for a student in a course
    func setGrade(course: Course, grade: Double) {
        if self.courses.firstIndex(of: course) != nil {
            self.grades.append(grade)
        }
    }

    // Get the grade of a student in a course
    func getGrade(course: Course) -> Double? {
        if let index = courses.firstIndex(of: course) {
            return grades[index]
        }
        return nil
    }

    // Calculate the GPA of the student
    func calculateGpa() -> Double {
        var sum = 0.0
        for grade in grades {
            sum += grade
        }
        return ((sum / Double(grades.count)) / 100) * 4
    }

    // Get the name of the student
    func getName() -> String {
        return name
    }

    // Enroll the student in a course
    func enrollCourse(course: Course) {
        courses.append(course)
        course.enrollStudent(student: self)
    }
}

// Start the program
Main.main()