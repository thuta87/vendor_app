import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
//import 'package:image_form_field/image_form_field.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/models/product.dart';
import 'package:vendor_app/models/category.dart';
import 'package:vendor_app/models/product_connector.dart';
import 'package:http/http.dart' as http;


class ProductDataTable extends StatefulWidget {
  final Function toggleView;
  ProductDataTable({
    this.toggleView
  });

  @override
  _ProductDataTableState createState() => _ProductDataTableState();
}



class _ProductDataTableState extends State<ProductDataTable> {
  List<Product> _products;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController product_name_Controller;
  TextEditingController description_Controller;
  TextEditingController image_Controller;
  TextEditingController category_id_Controller;
  TextEditingController collection_id_Controller;
  TextEditingController tags_Controller;
  TextEditingController original_price_Controller;
  TextEditingController retail_price_Controller;
  TextEditingController sku_Controller;
  TextEditingController barcode_Controller;
  TextEditingController negative_qty_Controller;
  TextEditingController is_physical_Controller;
  TextEditingController weight_Controller;
  Product _selectedProduct;
  bool _isUpdating;
  String _titleProgress;

  String _mySelection;

  //For category dropdown
  final String url = "http://192.168.0.135:3000/categories/";

  List data = List();

  Future<String> getCData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }
  //end

  void initState(){
    super.initState();
    this.getCData();// Calling categories method
    _products=[];
    _isUpdating = false;
    _titleProgress = 'Product Management';
    _scaffoldKey=GlobalKey();

    product_name_Controller=TextEditingController();
    description_Controller=TextEditingController();
    image_Controller=TextEditingController();
    category_id_Controller=TextEditingController();
    collection_id_Controller=TextEditingController();
    tags_Controller=TextEditingController();
    original_price_Controller=TextEditingController();
    retail_price_Controller=TextEditingController();
    sku_Controller=TextEditingController();
    barcode_Controller=TextEditingController();
    negative_qty_Controller=TextEditingController();
    is_physical_Controller=TextEditingController();
    weight_Controller=TextEditingController();

  }

  _showProgress(String message){
    setState(() {
      _titleProgress=message;
    });
  }

  _showSnackBar(context,message){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  _getProducts(){
    _showProgress('Loading products...');
    Services.getProducts().then((products) {
      setState(() {
        _products = products;
      });

      _showProgress('Product Management'); // Reset the title...
      print(products);
      print("Length ${products.length}");
    });
  }

  _addProduct(){
    if (product_name_Controller.text.isEmpty || _mySelection.isEmpty || collection_id_Controller.text.isEmpty) {
      print(_mySelection);
      print('Empty Fields');
      return;
    }
    _showProgress('Adding product...');

    print(product_name_Controller.text);

    Services.addProduct(product_name_Controller.text, description_Controller.text, image_Controller.text, int.parse(_mySelection) , int.parse(collection_id_Controller.text), tags_Controller.text, int.parse(original_price_Controller.text), int.parse(retail_price_Controller.text), sku_Controller.text, barcode_Controller.text, int.parse(negative_qty_Controller.text), int.parse(is_physical_Controller.text), int.parse(weight_Controller.text))
        .then((result) {
          print(result);
      if ('success' == result) {
        _getProducts(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });


  }

  _editProduct(Product product){
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Employee...');
    Services.editProduct(product.product_id,product_name_Controller.text, description_Controller.text, image_Controller.text, int.parse(_mySelection) , int.parse(collection_id_Controller.text), tags_Controller.text, int.parse(original_price_Controller.text), int.parse(retail_price_Controller.text), sku_Controller.text, barcode_Controller.text, int.parse(negative_qty_Controller.text), int.parse(is_physical_Controller.text), int.parse(weight_Controller.text))
        .then((result) {
      if ('success' == result) {
        _getProducts(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _removeProduct(){

  }

  _clearValues(){
    product_name_Controller.text='';
    description_Controller.text='';
    image_Controller.text='';
    category_id_Controller.text='';
    collection_id_Controller.text='';
    tags_Controller.text='';
    original_price_Controller.text='';
    retail_price_Controller.text='';
    sku_Controller.text='';
    barcode_Controller.text='';
    negative_qty_Controller.text='';
    is_physical_Controller.text='';
    weight_Controller.text='';
    _mySelection=null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
          backgroundColor: Colors.lightBlue[200],
          title: Text(_titleProgress),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _addProduct();
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _clearValues();
              },
            ),
          ]
      ),
      body:

      Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  maxLength: 100,
                  cursorColor: Colors.lightBlue,
                  controller: product_name_Controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Product Name'
                  ),
                ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                maxLength: 1000,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                controller: description_Controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: image_Controller,
                decoration: InputDecoration.collapsed(
                    border: OutlineInputBorder(),
                    hintText: 'Image'
                ),
              ),
            ),
            /*
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: category_id_Controller,
                decoration: InputDecoration.collapsed(
                    hintText: 'Category ID'
                ),
              ),
            ),
            */
            Padding(
              padding: EdgeInsets.all(20.0),
              child: new DropdownButton(
                items: data.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item['category_name']),
                    value: item['category_id'].toString(),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    _mySelection = newVal;
                  });
                },
                hint: Text(
                  "Please select the category!",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                value: _mySelection,
                elevation: 2,
              ),

            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: collection_id_Controller,
                decoration: InputDecoration.collapsed(
                    border: OutlineInputBorder(),
                    hintText: 'Collection ID'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: tags_Controller,
                decoration: InputDecoration.collapsed(
                    border: OutlineInputBorder(),
                    hintText: 'Tags'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: original_price_Controller,
                decoration: InputDecoration.collapsed(
                    border: OutlineInputBorder(),
                    hintText: 'Original Price'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: retail_price_Controller,
                decoration: InputDecoration.collapsed(
                    border: OutlineInputBorder(),
                    hintText: 'Retail Price'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: sku_Controller,
                decoration: InputDecoration.collapsed(
                    border: OutlineInputBorder(),
                    hintText: 'SKU'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: barcode_Controller,
                decoration: InputDecoration.collapsed(
                    border: OutlineInputBorder(),
                    hintText: 'Barcode'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: negative_qty_Controller,
                decoration: InputDecoration.collapsed(
                    border: OutlineInputBorder(),
                    hintText: 'Negative Qty'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: is_physical_Controller,
                decoration: InputDecoration.collapsed(
                    border: OutlineInputBorder(),
                    hintText: 'Is Physical'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: weight_Controller,
                decoration: InputDecoration.collapsed(
                    border: OutlineInputBorder(),
                    hintText: 'Weight'
                ),
              ),
            ),
            _isUpdating?
            Row(
              children: <Widget>[
                OutlineButton(
                    child: Text('EDIT'),
                    onPressed: (){
                      _editProduct(_selectedProduct);
                    }
                ),
                OutlineButton(
                    child: Text('CANCEL'),
                    onPressed: (){
                        setState(() {
                          _isUpdating=false;
                        });
                        _clearValues();
                    }
                ),
              ],
            ) : Container(),
          ],
        ),
      ),

    );
  }
}


