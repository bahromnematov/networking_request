import 'dart:convert';

import 'package:http/http.dart';

import '../model/post_model.dart';

class Network {
  static String BASE = "dummy.restapiexample.com";

  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

/* Http Apis*/

  static String API_LIST = "/api/v1/employees";
  static String API_LISTN = "/api/v1/employees/";
  static String API_CREATE = "/api/v1/create";
  static String API_UPDATE = "/api/v1/update/"; //{id}
  static String API_DELETE = "/api/v1/delete/"; //{id}

  /*HTTP Request*/
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
      return "sa";

  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
      return 'sasa';

  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 202) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> DELETE(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }


  static Map<String,String> paramsCreate(Post post){
    Map<String,String> params=Map();
    params.addAll({
      'employee_name':post.employee_name!,
      'employee_salary':post.employee_salary.toString(),
      'employee_age':post.employee_age.toString(),
      'profile_image':post.profile_image!,
    });
    return params;

  }

  static Map<String,String> paramsUpdate(Post post){
    Map<String,String> params=Map();
    params.addAll({
      'id':post.id.toString(),
      'employee_name':post.employee_name!,
      'employee_salary':post.employee_salary.toString(),
      'profile_image':post.profile_image!,
      'employee_age':post.employee_age.toString(),
    });
    return params;

  }




  /* http parsing */
 static List<Post> parsePostList(String response){
   dynamic json= jsonDecode(response);
   var date =List<Post>.from(json["data"].map((x)=>Post.fromJson(x)));
   return date;
 }


}
