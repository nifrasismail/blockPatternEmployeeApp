import 'dart:async';

import 'Employee.dart';

// TODO: imports
// TODO: list of employees
// TODO: stream controllers
// TODO: stream sink getter
// TODO: constructor - add data; listen to changes
// TODO: core functions
// TODO: dispose
class EmployeeBloc {
  //employee collection

  //sink to add data to UI
  //stream  to get data from streams ( pipe )
  //

  List<Employee> _employeeList = [
    Employee(1, "Empllyee 1", 10000.0),
    Employee(2, "Empllyee 2", 20000.0),
    Employee(3, "Empllyee 3", 30000.0),
    Employee(4, "Empllyee 4", 40000.0),
    Employee(5, "Empllyee 5", 50000.0)
  ];

  //init employee controllers for each events
  final _employeeListStreamController = StreamController<List<Employee>>();
  final _salaryIncrementStreamController = StreamController<Employee>();
  final _salaryDecrementStreamController = StreamController<Employee>();

  //getters

  //this is responsible to handling the data flow ( so called as stream )
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  //this is to outputting the data to UI
  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  //
  StreamSink<Employee> get employeeSalaryIncrement =>
      _salaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _salaryDecrementStreamController.sink;

  EmployeeBloc() {
    //adding the data to the stream
    _employeeListStreamController.add(_employeeList);

    //listen to the changes
    _salaryIncrementStreamController.stream.listen(_incrementSalary);
    _salaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary + incrementSalary;
    //update the employee list to the sink
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary - decrementSalary;
    //update the employee list to the sink
    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeListStreamController.close();
    _salaryDecrementStreamController.close();
    _salaryIncrementStreamController.close();
  }
}
