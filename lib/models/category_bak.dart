import 'dart:async';
import 'package:http/http.dart' as http;

class Category {

  void getCategories() async{
    var url='http://192.168.0.50:3000/categories';

    var data = {};
    var response = await http.post(url, body:data);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('A network error occurred');
    }
    /*
    var url='http://localhost:3000/categories';
    return http.get(url);

     */
  }

}