import 'package:flutter/material.dart';
import 'package:vendor_app/screens/dashboard/product_listing.dart';
import 'package:vendor_app/screens/dashboard/category_listing.dart';
import 'package:vendor_app/screens/home/user_list.dart';
import 'package:vendor_app/services/auth.dart';
import 'package:vendor_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  final Function toggleView;
  Home({
    this.toggleView
  });

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {


  final String url="";
  List data;

  var items = [
    {
      'title': 'Products',
      'img': 'img/product.png',
      'link': ProductDataListing(),
    },
    {
      'title': 'Categories',
      'img': 'img/category.png',
      //'link': CategoryDataListing(),
    },
    {
      'title': 'Channels',
      'img': 'img/channel.png',
      //'link': ChannelDataListing(),
    },
    {
      'title': 'Collections',
      'img': 'img/collection.png',
      //'link': CollectionDataListing(),
    },
  ];

  final AuthService _auth = AuthService();

  _MenuRoute(String prd_name){
    //print('I got it'+prd_name);
    prd_name=="Products" ?
      Navigator.push(
          context,
          MaterialPageRoute(
            //here
              builder: (context) => ProductDataListing()
          )
      )
      //ProductDataListing()
    : prd_name=="Categories" ?
    Navigator.push(
        context,
        MaterialPageRoute(
          //here
            builder: (context) => CategoryDataListing()
        )
    )
          : prd_name == "Channels" ?
          print("Channels!!!!!!!!!!")
            : prd_name == "Collections" ?
            print("Collections!!!!!!!!!")
              : print("Nothing at ALL!!!!!!!!!!!!!!!");
    //ProductDataListing();
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Dashboard'),
          backgroundColor: Colors.lightBlue[200],
          elevation: 0.0,
          /*
          actions: <Widget>[
            FlatButton.icon(onPressed: () async {
              await _auth.signOut();
            }, icon: Icon(Icons.power_settings_new), label: Text('Logout'), color: Colors.orange[90]
            )
          ],
          */

        ),

        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.9),
            itemCount: 4,
            itemBuilder: (context, i) {
              return InkWell(
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      child: Container(
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                        child: Center(
                          child: Container(
                            child: Text(
                              items[i]['title'],
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Colors.white, style: BorderStyle.solid)),
                          ),
                        ),
                        //buildTitle(items[i]['title']),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(items[i]['img']),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
                /*
                onTap: () {
                  widget.toggleView();
                },
                */

                onTap: () => {
                  _MenuRoute(items[i]['title'])
                  /*
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        //here

                          builder: (context) => ProductDataListing()

                      )
                  )
                  */
                },

              );
            }),


        //UserList(),


        drawer:new Drawer(
          child: new ListView(
            children: <Widget>[
//Header
              new UserAccountsDrawerHeader(
                accountName: Text('Admin'),
                accountEmail: Text('thuta87@gmail.com'),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: new BoxDecoration(
                    color: Colors.lightBlue[100]
                ),
              ),
//Body
              InkWell(
                  onTap: (){},
                  child: ListTile(
                    title: Text('Home Page'),
                    leading: Icon(Icons.home),
                  )
              ),

              InkWell(
                  onTap: (){},
                  child: ListTile(
                    title: Text('My Account'),
                    leading: Icon(Icons.person),
                  )
              ),

              InkWell(
                  onTap: (){},
                  child: ListTile(
                    title: Text('My Orders'),
                    leading: Icon(Icons.shopping_basket),
                  )
              ),

              InkWell(
                  onTap: (){},
                  child: ListTile(
                    title: Text('Favourites'),
                    leading: Icon(Icons.favorite),
                  )
              ),
              InkWell(
                  onTap: (){},
                  child: ListTile(
                    title: Text('Settings'),
                    leading: Icon(Icons.settings),
                  )
              ),

              InkWell(
                  onTap: (){},
                  child: ListTile(
                    title: Text('About'),
                    leading: Icon(Icons.info),
                  )
              ),

              InkWell(
                  onTap: () async {
                    print('before');
                    await _auth.signOut();
                    print('after');
                  },
                  child: ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.power_settings_new),
                  )
              ),
            ],
          ),
        ),

      ),
    );
  }
}
//









