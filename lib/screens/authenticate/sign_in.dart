import 'package:flutter/material.dart';
import 'package:vendor_app/services/auth.dart';
import 'package:vendor_app/resources/constants.dart';
import 'package:vendor_app/resources/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({
    this.toggleView
  });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey= GlobalKey<FormState>();
  bool loading= false;

  //txt field state
  String email="";
  String password ="";
  String error="";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      /*
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[200],
        elevation: 0.0,
        title: Text('Please Sign In.'),
        actions: <Widget>[
          /*
          new InkResponse(
              onTap: () {},
              child: new Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Center(
                  child: new Text("Register"),
                ),
              )),
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () {
              widget.toggleView();
            }
            ),

          FlatButton.icon(onPressed: () {
            widget.toggleView();
          },
              icon: Icon(Icons.person),
              label: Text('Register'))

           */
        ],
      ),
      */
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: 150.0,
            horizontal: 50.0
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              SizedBox(height: 10.0),
              Text('Hello there, welcome back',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0,fontFamily: 'SFUIDisplay')
              ),
              SizedBox(height: 20.0),

              TextFormField(
                decoration: new InputDecoration(
                  labelText: "Enter Email",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if(val.length==0) {
                    return "Email cannot be empty";
                  }else{
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
                onChanged: (val) {
                  setState(() => email = val);
                },
                /*
                decoration: textInputDecoration.copyWith(hintText: 'name@mail.com',prefixIcon: Icon(Icons.person_outline)),
                validator: (val) => val.isEmpty ? 'Enter an email address.' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
                 */
              ),

              SizedBox(height: 20.0),
              TextFormField(
                decoration: new InputDecoration(
                  labelText: "Enter Password",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if(val.length==0) {
                    return "Password cannot be empty";
                  }else{
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
                /*
                decoration: textInputDecoration.copyWith(hintText: 'password',prefixIcon: Icon(Icons.lock_outline)),
                validator: (val) => val.length<6 ? 'Enter a password should be at least 6 characters.' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
                */
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey)),
                color: Colors.grey[400],
                child: Text(
                  'SIGN IN',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() => loading=true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                    if (result == null) {
                      setState(() =>
                      error = 'Unauthorized access with those credentials!');
                      loading=false;
                    }
                  }
                 /*
                  print(email);
                  print(password);
                 */
                },
              ),
              Text('New here?',style: TextStyle(color: Colors.grey)),
              GestureDetector(
                child: Text(
                    'Sign Up instead',
                    style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)
                ),
                onTap: (){
                  widget.toggleView();
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 10.0,fontFamily: 'SFUIDisplay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
