import 'package:flutter/material.dart';
import 'package:vendor_app/models/category.dart';
import 'package:vendor_app/models/category_connector.dart';
import 'package:vendor_app/screens/dashboard/category_listing.dart';


class CategoryDetail extends StatefulWidget {
  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  List<Category> cat;
  int c_id=C_IDClass.GCID;
  //final prd= P_IDClass.prd_det;

  void initState() {
    super.initState();
    getCatData(c_id);
  }
  getCatData(int cid){
    Services.getCategory_det(cid).then((category_det) {
      setState(() {
        print('Gotcha!!!');
        cat=category_det;
      });

      print('Got category detail.');
      print(category_det);
      print("Category Detail Length ${category_det.length}");
    });
  }
  clearData() {
    setState(() {
      cat = [];
    });
    print('Clear Data');
    print(cat);
  }

  @override

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: clearData() ,
        child:
        Scaffold(
            appBar: AppBar(
              title: Text('Category Detail'),
              backgroundColor: Colors.lightBlue[200],
              elevation: 0.0,
            ),
            body:Container(
              child: new ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) =>
                      buildCategoryCard(context, index)),
            )
        )
    );
  }
}

Widget buildCategoryCard(BuildContext context, int index) {

  var cat;
  if (cat==[]) {
    print('NULL');
    print(C_IDClass.cat_det[index].category_name);
  }else{
    print('Not Null');
    print(C_IDClass.cat_det[index].category_name);
    cat=[];
  }

  cat = C_IDClass.cat_det[index];

  print('internal cat');
  print(cat);

  double c_width = MediaQuery.of(context).size.width*0.8;

  return new Container(
    width: c_width,
    child: Card(
      elevation: 10.0,
      margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
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
                Text(cat.category_name, style: new TextStyle(fontSize: 20.0),),
              ]),
            ),
            Image.network(cat.category_image),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Row(
                children: <Widget>[
                  Text(cat.category_code, style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                  Spacer(),
                ],
                //Split
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Row(
                children: <Widget>[
                  Text("Category Description:", style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),),
                  Spacer()                    //  Icon(Icons.edit),
                ],
                //Split
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 5.0),
              child: Row(children: <Widget>[
                Flexible(
                  child: new Text(cat.description),
                ),
              ]),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 5.0),
                child: FloatingActionButton(
                  onPressed: (){},
                  child: Icon(Icons.edit),
                )
            )
          ],
        ),
      ),
    ),
  );
}






