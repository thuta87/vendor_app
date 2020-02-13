import 'package:flutter/material.dart';
import 'package:vendor_app/services/auth.dart';
import 'package:vendor_app/resources/constants.dart';
import 'package:vendor_app/resources/loading.dart';

class Register  extends StatefulWidget {

  final Function toggleView;
  Register({
    this.toggleView
  });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey= GlobalKey<FormState>();
  bool loading= false;

  //txt field state
  String email="";
  String fname="";
  String lname="";
  String mobile="";
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
        title: Text('Sign Up'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
            widget.toggleView();
          },
              icon: Icon(Icons.person),
              label: Text('Sign In'))
        ],
      ),
      */
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 50.0
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text('Get on Board',
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
                decoration: textInputDecoration.copyWith(hintText: 'name@mail.com'),
                validator: (val) => val.isEmpty ? 'Enter an email address.' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },

                */
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: new InputDecoration(
                  labelText: "Enter your first name.",
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
                    return "Your first name cannot be empty";
                  }else{
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
                onChanged: (val) {
                  setState(() => fname = val);
                },
                /*
                decoration: textInputDecoration.copyWith(hintText: 'First Name'),
                validator: (val) => val.isEmpty ? 'Enter your first name.' : null,
                onChanged: (val) {
                  setState(() => fname = val);
                },
                */
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: new InputDecoration(
                  labelText: "Enter your last name.",
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
                    return "Your last name cannot be empty";
                  }else{
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
                onChanged: (val) {
                  setState(() => lname = val);
                },
                /*
                decoration: textInputDecoration.copyWith(hintText: 'Last Name'),
                validator: (val) => val.isEmpty ? 'Enter your last name.' : null,
                onChanged: (val) {
                  setState(() => lname = val);
                },
                */
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: new InputDecoration(
                  labelText: "Enter your phone number.",
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
                    return "Your phone number cannot be empty";
                  }else{
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
                onChanged: (val) {
                  setState(() => mobile = val);
                },
                /*
                decoration: textInputDecoration.copyWith(hintText: '09123456789'),
                validator: (val) => val.isEmpty ? 'Enter your phone number.' : null,
                onChanged: (val) {
                  setState(() => mobile = val);
                },
                */
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: new InputDecoration(
                  labelText: "Enter password.",
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
                onChanged: (val) {
                  setState(() => password = val);
                },
                /*
                decoration: textInputDecoration.copyWith(hintText: 'passsword') ,
                validator: (val) => val.length<6 ? 'Enter a password should be at least 6 characters.' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
                */
              ),
              /*
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.length<6 ? 'Enter a password should be at least 6 characters.' : null,
                obscureText: true,s
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              */
              SizedBox(height: 20.0),
              Text("By creating an account, you agree to the Terms and Use and Privacy Policy.",
                  style: TextStyle(color: Colors.grey)
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blueGrey[200],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading=true);

                    dynamic result = await _auth.registerWithEmailAndPassword(email, fname, lname, mobile, password);

                    if (result == null) {
                      setState(() => error='Please register with a valid email address.');
                      loading=false;
                    }
                  }
                },
              ),
              GestureDetector(
                child: Text(
                    'I am already a member.',
                    style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)
                ),
                onTap: (){
                  widget.toggleView();
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
