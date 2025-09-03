void main() {
  Student student1 = Student('IT', "BVRIT");
  print(student1.course);
  Student student2 = Student('CSE', "BREW");
  print(student2.college);
  print(student1.getCourse());

  Topper topper = Topper("IT", "CVR");
  print(topper.course);
  topper.result();
}

class Student {
  String course = "";
  String college = "";
  Student(String course, String college) {
    this.course = course;
    this.college = college;
  }

  String getCourse() {
    return course;
  }
}

class Topper extends Student {
  Topper(String course, String college) : super(course, college);
  void result() {
    print("1st class");
  }
}
