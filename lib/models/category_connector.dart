import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vendor_app/models/category.dart';

class Services{
  static const SUMM = "http://192.168.0.135:3000/categories/";
  static const ADD = "http://192.168.0.135:3000/categories/add";
  static const EDIT = "http://192.168.0.135:3000/categories/edit";
  static const RMOV = "http://192.168.0.135:3000/categories/delete";
  static const DET = "http://192.168.0.135:3000/categories/";

  //Get product listing
  static Future<List<Category>> getCategories() async {
    try{

      var map = Map<String, dynamic>();

      map['action'] = 'Get_All_Categories' ;
      //final response = await http.post(ROOT,body: map);
      final response = await http.get(SUMM);

      //print('Get All Categories Data: ${response.body}');

      if(200==response.statusCode){
        List<Category> list = parseResponse(response.body);
        return list;
      }else{
        print('Another else');
        return List<Category>();
      }

    }catch(e){
      print(e);
      return List<Category>();
    }
  }



  static Future<List<Category>> getCategory_det(int category_id) async {
    try{
      var queryParameters = {
        'param1': category_id,
      };
      print(DET);
      print('HERE is start of convert link');
      var uri = DET+ "$category_id";
      print('HERE is end of convert link');
      print(uri);

      var map = Map<String, dynamic>();

      map['action'] = 'Get_Category_Det' ;
      //final response = await http.post(ROOT,body: map);
      //final response = await http.get(DET,"body":{"product_id":product_id});

      final response = await http.get(uri, headers: {"Accept": "application/json"});

      print('Get All Category Data: ${response.body}');

      if(200==response.statusCode){
        List<Category> list = parseResponse(response.body);
        return list;
      }else{
        print('Another else');
        return List<Category>();
      }

    }catch(e){
      print(e);
      print('Get Detail Call Error');
      return List<Category>();
    }
  }
  static List<Category> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
    return parsed.map<Category>((json)=>Category.fromJson(json)).toList();
  }

  //Add new product
  static Future<String> addCategory(String category_code, String category_name, String description, String category_image) async {
    try{
      print('Adding category in progress!!!!!');

      Map<String, String> headers = {"Content-type": "application/json"};

      var map = Map<String, dynamic>();
      //map['action'] = 'Add_Product' ;
      map['category_code'] = category_code ;
      map['category_name'] = category_name ;
      map['description'] = description ;
      map['catgegory_image'] = category_image ;

      //map=jsonEncode(map);
      var eMap = jsonEncode(map);

      print(jsonEncode(map));
      print('HERE is the start of calling API.!!!');
      final response = await http.post(ADD,headers: headers,body: eMap);
      print('API Call success!!!');

      print('Add Category Data: ${response.body}');

      if(200==response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      print(e);
      return "error";
    }
  }

  //Edit product
  static Future<String> editCategory(int category_id, String category_code, String category_name, String description, String category_image) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = 'Edit_Product' ;
      map['category_id'] = category_id ;
      map['category_code'] = category_code ;
      map['category_name'] = category_name ;
      map['description'] = description ;
      map['category_image'] = category_image ;

      final response = await http.post(EDIT,body: map);

      print('Edit Category Data: ${response.body}');

      if(200==response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }

  //Delete product
  static Future<String> deleteCategory(int category_id, String category_code, String category_name, String description, String category_image) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = 'Edit_Product' ;
      map['category_id'] = category_id ;
      map['category_code'] = category_code ;
      map['category_name'] = category_name ;
      map['description'] = description ;
      map['category_image'] = category_image ;

      final response = await http.post(RMOV,body: map);

      print('Delete Category Data: ${response.body}');

      if(200==response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }
}