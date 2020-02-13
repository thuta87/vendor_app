import 'dart:developer';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/models/product.dart';
import 'package:vendor_app/models/category.dart';
import 'package:vendor_app/models/product_connector.dart';
import 'package:vendor_app/screens/dashboard/product_managment.dart';

class ProductDataListing extends StatefulWidget {
  final Function toggleView;
  ProductDataListing({
    this.toggleView
  });

  @override
  _ProductDataListingState createState() => _ProductDataListingState();
}



class _ProductDataListingState extends State<ProductDataListing> {
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

  void initState(){
    super.initState();
    //ProductDataListing();
    _getProducts();
    _products=[];
    _isUpdating = false;
    _titleProgress = 'Product List';
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
    return ProductDataTable();
    /*
    if (product_name_Controller.text.isEmpty || category_id_Controller.text.isEmpty || collection_id_Controller.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding product...');

    Services.addProduct(product_name_Controller.text, description_Controller.text, image_Controller.text, category_id_Controller.text, collection_id_Controller.text, tags_Controller.text, original_price_Controller.text, retail_price_Controller.text, sku_Controller.text, barcode_Controller.text, negative_qty_Controller.bool, is_physical_Controller.bool, weight_Controller.int)
        .then((result) {
      if ('success' == result) {
        _getProducts(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });

    */
  }

  _editProduct(Product product){
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Product...');
    /*
    Services.editProduct(
        employee.id, _firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getProducts(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
     */
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
  }

  @override
  Widget build(BuildContext context) {
    print(_products);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightBlue[200],
            title: Text(_titleProgress),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDataTable()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _getProducts();
                },
              ),
            ]
        ),
        body: Container(
          child: new ListView.builder(
              itemCount: _products.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildProductCard(context, index)),
        )
    );
  }

  Widget buildProductCard(BuildContext context, int index) {
    print(_products);
    final prd = _products[index];
    return new Container(
      child: Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),

        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(prd.product_name, style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 5.0),
                child: Row(children: <Widget>[
                  Text(
                    prd.tags,
                    //"${DateFormat('dd/MM/yyyy').format(prd.startDate).toString()} - ${DateFormat('dd/MM/yyyy').format(prd.endDate).toString()}"
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  children: <Widget>[
                    Text("Ks. ${prd.retail_price}", style: new TextStyle(fontSize: 15.0),),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.lightBlue[200],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductDataTable()),
                        );
                      },
                    )
                    //  Icon(Icons.edit),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

