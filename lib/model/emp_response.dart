class EmpResponse {
  String? status;
  List<Employee>? data;
  String? message;


  EmpResponse({this.status,this.data,this.message});

  factory EmpResponse.fromJson(Map<String,dynamic> json)=> EmpResponse(
    status:json['status'],
    data:List<Employee>.from(json["data"].map((x)=>Employee.fromJson(x))),
    message:json['message'],
  );

  Map<String,dynamic> toJson()=>{
    "status":status,
    "data":List<dynamic>.from(data!.map((x) =>x.toJson() )),
    "message":message,
  };

}


class Employee {
  int? id;
  String? employee_name;
  int? employee_salary;
  int? employee_age;
  String? profile_image;

  Employee(
      {this.profile_image, this.employee_age, this.employee_name, this.employee_salary, this.id});


 factory Employee.fromJson(Map<String,dynamic> json)=>Employee(
    id: json['id'],
    employee_name: json['employee_name'],
    employee_salary: json['employee_salary'],
    employee_age: json['employee_age'],
    profile_image: json['profile_image'],
  );

 Map<String,dynamic> toJson()=>
     {
       "id": id,
       "employee_name": employee_name,
       "employee_salary": employee_salary,
       "employee_age": employee_age,
       "profile_image": profile_image,


     };

}