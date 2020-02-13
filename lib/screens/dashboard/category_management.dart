import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
//import 'package:image_form_field/image_form_field.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/models/category.dart';
import 'package:vendor_app/models/category_connector.dart';
import 'package:http/http.dart' as http;


class CategoryDataTable extends StatefulWidget {
  final Function toggleView;
  CategoryDataTable({
    this.toggleView
  });

  @override
  _CategoryDataTableState createState() => _CategoryDataTableState();
}



class _CategoryDataTableState extends State<CategoryDataTable> {
  List<Category> _categories;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController category_code_Controller;
  TextEditingController category_name_Controller;
  TextEditingController description_Controller;
  TextEditingController category_image_Controller;
  Category _selectedCategory;
  bool _isUpdating;
  String _titleProgress;

  String _mySelection;

  //For category dropdown
  final String url = "http://192.168.0.50:3000/categories/";

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
    this.getCData();// Calling for parent categories method
    _categories=[];
    _isUpdating = false;
    _titleProgress = 'Category Management';
    _scaffoldKey=GlobalKey();

    category_code_Controller=TextEditingController();
    category_name_Controller=TextEditingController();
    description_Controller=TextEditingController();
    category_image_Controller=TextEditingController();
  }

  _showProgress(String message){
    setState(() {
      _titleProgress=message;
    });
  }

  _showSnackBar(context,message){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  _getCategories(){
    _showProgress('Loading categories...');
    Services.getCategories().then((categories) {
      setState(() {
        _categories = categories;
      });

      _showProgress('Category Management'); // Reset the title...
      print(categories);
      print("Length ${categories.length}");
    });
  }

  _addCategory(){
    if (category_name_Controller.text.isEmpty) {
      //print(_mySelection);
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Category...');

    print(_mySelection);
    /*
    Services.addCategory(category_code_Controller.text, category_name_Controller.text, description_Controller.text, category_image_Controller.text)
        .then((result) {
      print(result);
      if ('success' == result) {
        _getCategories(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
    */

  }

  _editCategory(Category category){
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Category...');
    Services.editCategory(category.category_id, category_code_Controller.text, category_name_Controller.text, description_Controller.text, category_image_Controller.text)
        .then((result) {
      if ('success' == result) {
        _getCategories(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _removeCategory(){

  }

  _clearValues(){
    category_code_Controller.text='';
    category_name_Controller.text='';
    description_Controller.text='';
    category_image_Controller.text='';
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
                _addCategory();
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
                controller: category_code_Controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Category Code'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                maxLength: 100,
                cursorColor: Colors.lightBlue,
                controller: category_name_Controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Category Name'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: Colors.grey, style: BorderStyle.solid, width: 0.80
                    ),
                  ),
                  child: new DropdownButton(
                    items: data.map((item) {
                      return new DropdownMenuItem(
                        value: item['category_id'].toString(),
                        child: new Text(item['category_name']),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        _mySelection = newVal;
                      });
                    },
                    isExpanded: false,
                    underline: SizedBox(),
                    hint: Text(
                      "Please select the parent category.",
                      /*
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      */
                    ),
                    value: _mySelection,
                    elevation: 2,
                  ),
              )
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
                controller: category_image_Controller,
                decoration: InputDecoration.collapsed(
                    border: OutlineInputBorder(),
                    hintText: 'Image'
                ),
              ),
            ),
            _isUpdating?
            Row(
              children: <Widget>[
                OutlineButton(
                    child: Text('EDIT'),
                    onPressed: (){
                      _editCategory(_selectedCategory);
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


