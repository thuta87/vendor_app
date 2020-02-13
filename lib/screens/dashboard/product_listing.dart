import 'dart:developer';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/models/product.dart';
import 'package:vendor_app/models/category.dart';
import 'package:vendor_app/models/product_connector.dart';
import 'package:vendor_app/screens/dashboard/product_detail.dart';
import 'package:vendor_app/screens/dashboard/product_managment.dart';
import 'package:vendor_app/screens/home/home.dart';

class ProductDataListing extends StatefulWidget {
  final Function toggleView;
  ProductDataListing({
    this.toggleView
  });

  @override
  _ProductDataListingState createState() => _ProductDataListingState();
}

class P_IDClass {
  static int GPID;
  //static List<prd_det> list;

  static List prd_det;
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
  int p_id;

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

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


  _setProduct_ID(int prd_id){
    if(prd_id==0) {
      throw new ArgumentError();
    }
    //PData_ID.product_id=prd_id;
    P_IDClass.GPID=prd_id;
    //print(PData_ID.product_id);
  }

  _getProduct_detail(int prd_id){
    Services.getProduct_det(prd_id).then((product_det) {
      setState(() {
         print('Gotcha!!!');
         P_IDClass.prd_det=product_det;
      });

      print('Got product detail.');
      print(product_det);
      print("Product Detail Length ${product_det.length}");
    });
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

  _editProduct(Product product){
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Employee...');
    MaterialPageRoute(
        builder: (context) => ProductDataTable(),
    );
    /*
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
          leading: _isSearching ? const BackButton() : Container(),
          backgroundColor: Colors.lightBlue[200],
          //title: Text(_titleProgress),
          title: _isSearching ? _buildSearchField() : Text('Search'),
          actions: _buildActions(),
       /*
          <Widget>[
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
          ],
        */
      ),
        bottomNavigationBar: BottomAppBar(
            //color: Color.fromRGBO(58, 66, 86, 1.0),
            color: Colors.lightBlue[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: Colors.white),
                  onPressed: () {
                    _getProducts();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDataTable()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.account_box, color: Colors.white),
                  onPressed: () {},
                )
              ],
            ),
          ),

      body: Container(
      child: new ListView.builder(
          itemCount: _products.length,
          itemBuilder: (BuildContext context, int index) =>
              buildProductCard(context, index)),
    )
    );
  }

  //Search start
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery,
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  //Search end

  Widget buildProductCard(BuildContext context, int index) {
    bool _isEnabled = false;
    //print(_products);
    final prd = _products[index];
    return new Container(
      child: Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      child: Container(
      decoration: //BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          BoxDecoration(color: Colors.grey),
          child: ListTile(
            onTap: (){
              _selectedProduct=prd;
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            leading: Container(
              padding: EdgeInsets.only(right: 10.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      //left: new BorderSide(width: 1.0, color: Colors.grey),
                      right: new BorderSide(width: 1.0, color: Colors.white24)
                  )
              ),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            title: Text(
              prd.product_name,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: <Widget>[
                //Icon(Icons.linear_scale, color: Colors.lightBlue[200]),
                Text(prd.barcode, style: TextStyle(color: Colors.white)),
                //Text("Ks. ${prd.retail_price}", style: TextStyle(color: Colors.white)),
              ],
            ),
              trailing:
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0,),
                onPressed: (){
                  //_selectedProduct=prd.product_name;
                  print(prd);
                  //_editProduct(prd);
                  setState((){
                    _isEnabled = !_isEnabled;
                    //p_id=prd.product_id;
                    _setProduct_ID(prd.product_id);
                    _getProduct_detail(prd.product_id);
                  });
                  print(_isEnabled);


                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDetail()),
                    );


                }

            )
          )
      ),
    )

        /*
      Card(
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
      */

    );
  }
}

