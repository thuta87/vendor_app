import 'dart:convert';
import 'dart:developer';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/models/category.dart';
import 'package:vendor_app/models/category_connector.dart';
import 'package:vendor_app/screens/dashboard/category_detail.dart';
import 'package:vendor_app/screens/dashboard/category_management.dart';
import 'package:vendor_app/screens/home/home.dart';
import 'package:tree_view/tree_view.dart';

class CategoryDataListing extends StatefulWidget {
  final Function toggleView;
  CategoryDataListing({
    this.toggleView
  });

  @override
  _CategoryDataListingState createState() => _CategoryDataListingState();
}

class C_IDClass {
  static int GCID;
  //static List<prd_det> list;

  static List cat_det;
}

class _CategoryDataListingState extends State<CategoryDataListing> {
  List<Category> _categories;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController category_code_Controller;
  TextEditingController category_name_Controller;
  TextEditingController description_Controller;
  TextEditingController category_image_Controller;
  Category _selectedCategory;
  bool _isUpdating;
  String _titleProgress;
  int c_id;
  //var TreeCat;
  Map<dynamic,dynamic> TreeCat={};

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  void initState(){
    super.initState();
    //ProductDataListing();
    _getCategories();
    _categories=[];
    _isUpdating = false;
    _titleProgress = 'Categories List';

    _scaffoldKey=GlobalKey();

    category_code_Controller=TextEditingController();
    category_name_Controller=TextEditingController();
    description_Controller=TextEditingController();
    category_image_Controller=TextEditingController();

  }


  _setCategory_ID(int cat_id){
    if(cat_id==0) {
      throw new ArgumentError();
    }
    //PData_ID.product_id=prd_id;
    C_IDClass.GCID=cat_id;
    //print(PData_ID.product_id);
  }

  _getCategory_detail(int cat_id){
    Services.getCategory_det(cat_id).then((category_det) {
      setState(() {
        print('Gotcha!!!');
        C_IDClass.cat_det=category_det;
      });

      print('Got category detail.');
      print(category_det);
      print("Category Detail Length ${category_det.length}");
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

  _getCategories(){
    _showProgress('Loading categories...');
    Services.getCategories().then((categories) {
      setState(() {
        print('This is categories obj.');
        print(categories);
        _categories =  categories;

        //var cg = dict(categories);

        //TreeCat={for (var v in categories) v[0]: v[1] };


        TreeCat=Map.fromIterable(categories,
            key: (c) => c.category_id,
            value: (c) => c.category_name
        );

        /*
        TreeCat = Map.fromIterable(categories,
                                  key: (c) => 'category_id', value: (c) => c.category_id
                  );


        print ('Map 1 is HERE!!!!');
        print(TreeCat);
        */
      });


      _showProgress('Category Management'); // Reset the title...
      print(categories);
      print("Length ${categories.length}");
    });
  }

  _editCategory(Category category){
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Category...');
    MaterialPageRoute(
      builder: (context) => CategoryDataTable(), //ProductDataTable()
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
    final cats=_categories;
    //print('This is MAP TreeCat');
    //print(TreeCat);
    //Map mapBody = TreeCat;

    //Map mapBody = _categories;
    //Map mapBody =jsonDecode(_categories);

    return Scaffold(
        appBar: AppBar(
          leading: _isSearching ? const BackButton() : Container(),
          backgroundColor: Colors.lightBlue[200],
          //title: Text(_titleProgress),
          title: _isSearching ? _buildSearchField() : Text('Search'),
          actions: _buildActions(),
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
                  _getCategories();
                },
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryDataTable()),
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

        body:Container(
          child: new ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildCategoryCard(context, index)),
          //child: _CTreeView(mapBody)
        ),

    );
  }

  Widget _CTreeView(Map group, {
    double level = 0,
  }){
    print('cat in widget');

    print(group['category_names']);


    if (group['child'] != null) {
      List<Widget> subGroups = List<Widget>();

      for (Map subGroup in group['child']) {
        subGroups.add(
          _CTreeView(
            subGroup,
            level: level + 1,
          ),
        );
      }
      return Parent(
        parent: _card(
          group['category_name'],
          level* 20,
        ),
        childList: ChildList(
          children: subGroups,
        ),
      );

    } else {
        return _card(
          group['category_name'],
          level* 20,
        );
    }

    //End For a while in testing
    /*
    return TreeView(
      parentList: [
        Parent(
          parent: Text('Desktop'),
          childList: ChildList(
            children: <Widget>[
              Parent(
                parent: Text('documents'),
                childList: ChildList(
                  children: <Widget>[
                    Text('Resume.docx'),
                    Text('Billing-Info.docx'),
                  ],
                ),
              ),
              Text('MeetingReport.xls'),
              Text('MeetingReport.pdf'),
              Text('Demo.zip'),
            ],
          ),
        ),
      ],
    );
    */
  }
  //Search start
  Widget _card(
      String groupName,
      double leftPadding,
      ) {
    return Container(
      padding: EdgeInsets.only(
        left: leftPadding + 5,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
      ),
      height: 100,
      child: Row(
        children: <Widget>[
          Container(
            width: 250,
            child: Row(
              children: <Widget>[
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Rubik%27s_cube.svg/220px-Rubik%27s_cube.svg.png',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    'Category',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          InkWell(
            //TODO:Empty method here
            onTap: () {},
            child: Icon(
              Icons.group_add,
              size: 40,
            ),
          )
        ],
      ),
    );
  }

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

  Widget buildCategoryCard(BuildContext context, int index) {
    bool _isEnabled = false;
    //print(_products);
    final cat = _categories[index];

    print('HERE is cat data object');
    print(cat);

    return new Container(
        child: Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          child: Container(
              decoration: //BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              BoxDecoration(color: Colors.grey),
              child: ListTile(
                  onTap: (){

                    _selectedCategory=cat;

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
                    cat.category_name,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      //Icon(Icons.linear_scale, color: Colors.lightBlue[200]),
                      Text(cat.category_code, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  trailing:
                  IconButton(
                      icon: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0,),
                      onPressed: (){
                        //_selectedProduct=prd.product_name;

                        print(cat);
                        //_editProduct(prd);
                        setState((){
                          _isEnabled = !_isEnabled;
                          //p_id=prd.product_id;
                          _setCategory_ID(cat.category_id);
                          _getCategory_detail(cat.category_id);
                        });

                        print(_isEnabled);


                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CategoryDetail()),
                        );


                      }

                  )
              ),
          ),
        )
    );
  }
}

