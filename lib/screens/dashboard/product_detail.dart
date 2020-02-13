import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/models/product.dart';
import 'package:vendor_app/models/product_connector.dart';
import 'package:vendor_app/screens/dashboard/product_listing.dart';


class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<Product> prd;
  int p_id=P_IDClass.GPID;
  //final prd= P_IDClass.prd_det;

  void initState() {
    super.initState();
    getProData(p_id);
  }
  getProData(int pid){
    Services.getProduct_det(pid).then((product_det) {
      setState(() {
        print('Gotcha!!!');
        prd=product_det;
      });

      print('Got product detail.');
      print(product_det);
      print("Product Detail Length ${product_det.length}");
    });
  }
  clearData() {
    setState(() {
      prd = [];
    });
    print('Clear Data');
    print(prd);
  }

  @override

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: clearData() ,
        child:
          Scaffold(
              appBar: AppBar(
                title: Text('Product Detail'),
                backgroundColor: Colors.lightBlue[200],
                elevation: 0.0,
              ),
              body:Container(
                child: new ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) =>
                        buildProductCard(context, index)),
              )
            )
          );
  }
}

Widget buildProductCard(BuildContext context, int index) {

  var prd;
  if (prd==[]) {
    print('NULL');
    print(P_IDClass.prd_det[index].product_name);
  }else{
    print('Not Null');
    print(P_IDClass.prd_det[index].product_name);
    prd=[];
  }

  prd = P_IDClass.prd_det[index];

  print('internal prd');
  print(prd);

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
                  Text(prd.product_name, style: new TextStyle(fontSize: 20.0),),
                ]),
              ),
              Image.network(prd.image),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  children: <Widget>[
                    Text("Ks. ${prd.retail_price}", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                    Spacer(),
                    Text("Weight: ${prd.weight}", style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),//  Icon(Icons.edit),
                  ],
                  //Split
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  children: <Widget>[
                    Text("Note:", style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),),
                    Spacer()                    //  Icon(Icons.edit),
                  ],
                  //Split
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: (prd.negative_qty==0) ?
                  Text(prd.product_name+" can't be sold in negative quantity."
                      , style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)
                  ):
                  Text(prd.product_name+" can be sold in negative quantity."
                      , style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)
                  ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: (prd.is_physical ==1) ?
                  Text(prd.product_name+" is a physical product."
                      , textAlign: TextAlign.left
                      , style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)
                  ):
                  Text(prd.product_name+" is not a physical product."
                      , textAlign: TextAlign.left
                      , style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 5.0),
                child: Row(children: <Widget>[
                  Text(
                    "Tags: "+prd.tags,
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  children: <Widget>[
                    Text("Product Description:", style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),),
                    Spacer()                    //  Icon(Icons.edit),
                  ],
                  //Split
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 5.0),
                child: Row(children: <Widget>[
                  Flexible(
                    child: new Text(prd.description),
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






