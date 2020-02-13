import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vendor_app/models/product.dart';

class Services{
  static const ROOT = "http://192.168.0.135:3000/products/";
  static const ADD = "http://192.168.0.135:3000/products/add";
  static const EDIT = "http://192.168.0.135:3000/products/edit";
  static const RMOV = "http://192.168.0.135:3000/products/delete";
  static const DET = "http://192.168.0.135:3000/products/";

  //Get product listing
  static Future<List<Product>> getProducts() async {
    try{

      var map = Map<String, dynamic>();

      map['action'] = 'Get_All_Products' ;
      //final response = await http.post(ROOT,body: map);
      final response = await http.get(ROOT);

      print('Get All Product Data: ${response.body}');

      if(200==response.statusCode){
          List<Product> list = parseResponse(response.body);
          return list;
      }else{
        print('Another else');
        return List<Product>();
      }

    }catch(e){
      print(e);
      return List<Product>();
    }
  }



  static Future<List<Product>> getProduct_det(int product_id) async {
    try{
      var queryParameters = {
        'param1': product_id,
      };
      print(DET);
      print('HERE is start of convert link');
      var uri = DET+ "$product_id";
      print('HERE is end of convert link');
      print(uri);

      var map = Map<String, dynamic>();

      map['action'] = 'Get_Product_Det' ;
      //final response = await http.post(ROOT,body: map);
      //final response = await http.get(DET,"body":{"product_id":product_id});

      final response = await http.get(uri, headers: {"Accept": "application/json"});

      print('Get All Product Data: ${response.body}');

      if(200==response.statusCode){
        List<Product> list = parseResponse(response.body);
        return list;
      }else{
        print('Another else');
        return List<Product>();
      }

    }catch(e){
      print(e);
      print('Get Detail Call Error');
      return List<Product>();
    }
  }
  static List<Product> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
    return parsed.map<Product>((json)=>Product.fromJson(json)).toList();
  }

  //Add new product
  static Future<String> addProduct(String product_name, String description, String image, int category_id, int collection_id, String tags, int original_price, int retail_price, String sku, String barcode, int negative_qty, int is_physical, int weight) async {
    try{
      print('Adding product in progress!!!!!');

      Map<String, String> headers = {"Content-type": "application/json"};

      var map = Map<String, dynamic>();
      //map['action'] = 'Add_Product' ;
      map['product_name'] = product_name ;
      map['description'] = description ;
      map['image'] = image ;
      map['category_id'] = category_id ;
      map['collection_id'] = collection_id ;
      map['tags'] = tags ;
      map['original_price'] = original_price ;
      map['retail_price'] = retail_price ;
      map['sku'] = sku ;
      map['barcode'] = barcode ;
      map['negative_qty'] = negative_qty ;
      map['is_physical'] = is_physical ;
      map['weight'] = weight ;

      //map=jsonEncode(map);
      var eMap = jsonEncode(map);

      print(jsonEncode(map));
      print('HERE is the start of calling API.!!!');
      final response = await http.post(ADD,headers: headers,body: eMap);
      print('API Call success!!!');

      print('Add Product Data: ${response.body}');

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
  static Future<String> editProduct(int product_id, String product_name, String description, String image, int category_id, int collection_id, String tags, int original_price, int retail_price, String sku, String barcode, int negative_qty, int is_physical, int weight) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = 'Edit_Product' ;
      map['product_id'] = product_id ;
      map['product_name'] = product_name ;
      map['description'] = description ;
      map['image'] = image ;
      map['category_id'] = category_id ;
      map['collection_id'] = collection_id ;
      map['tags'] = tags ;
      map['original_price'] = original_price ;
      map['retail_price'] = retail_price ;
      map['sku'] = sku ;
      map['barcode'] = barcode ;
      map['negative_qty'] = negative_qty ;
      map['is_physical'] = is_physical ;
      map['weight'] = weight ;

      final response = await http.post(EDIT,body: map);

      print('Edit Product Data: ${response.body}');

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
  static Future<String> deleteProduct(int product_id, String product_name, String description, String image, int category_id, int collection_id, String tags, int original_price, int retail_price, String sku, String barcode, bool negative_qty, bool is_physical, int weight) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = 'Edit_Product' ;
      map['product_id'] = product_id ;
      map['product_name'] = product_name ;
      map['description'] = description ;
      map['image'] = image ;
      map['category_id'] = category_id ;
      map['collection_id'] = collection_id ;
      map['tags'] = tags ;
      map['original_price'] = original_price ;
      map['retail_price'] = retail_price ;
      map['sku'] = sku ;
      map['barcode'] = barcode ;
      map['negative_qty'] = negative_qty ;
      map['is_physical'] = is_physical ;
      map['weight'] = weight ;

      final response = await http.post(RMOV,body: map);

      print('Delete Product Data: ${response.body}');

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