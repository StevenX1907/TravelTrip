import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Service {
  //create the method to save user

  Future<http.Response> saveUser(
     String email, String password) async {
    //create uri
    var uri = Uri.parse("http://10.0.2.2:8080/register");
    //header
    Map<String, String> headers = {"Content-Type": "application/json"};
    //body
    Map data = {
      // 'name': '$userName',
      'email': '$email',
      'password': '$password',
    };
    //convert the above data into json
    var body = json.encode(data);
    var response = await http.post(uri, headers: headers, body: body);

    //print the response body
    print("${response.body}");

    return response;
  }
}