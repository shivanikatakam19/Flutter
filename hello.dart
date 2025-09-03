void main() {
  print('Hello world'); // printing the statement
  String name = "Shivani"; //String data type
  int age = 25; // int data type
  bool isHuman = true; // boolean data type
  List<String> namesList = ['Shivani', 'test', 'Test 1']; // list of strings
  List objects = ['kjvhbh', 88, 11.00, true];
  print(greet);
  print(name);
  namesList.add('siva');
  namesList.remove('reddy');
  print(namesList);
  print(objects);
  Map student = {'name': 'vamsi', 'age': 25};
  print(student['age']);
}

String greet = greeting();

String greeting() {
  // function returing a string
  return "hello world";
}
