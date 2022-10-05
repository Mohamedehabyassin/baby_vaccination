import 'package:flutter/material.dart';
import 'package:vacc_app/shared/auth_service.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _email = '';
  String _password = '';
  final AuthService _auth = AuthService();
  String _error = '';
  var myColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Register")),
        backgroundColor: Colors.indigo[900],
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.indigo[900],
      body: ListView(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(315.0),
              //    bottomLeft: Radius.circular(315.0)
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(top: 60, left: 40, right: 80),
            child: Column(children: <Widget>[
              Container(
                height: 280,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Image.asset(
                  "assets/section-2.png",
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.blue[700]),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() => _email = val);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.blue[700]),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => _password = val);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      )),
                ),
              ),
              Container(
                width: 180,
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 70),
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        _email, _password);
                    if (result == null) {
                      setState(() {
                        _error = "Kindly , Enter a Valid E-mail";
                      });
                    }
                    // _showMyDialog();
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    _auth.signInWithGoogle();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.black12;
                        return Colors.red; // Use the component's default.
                      },
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            'assets/google.png',
                          )),
                      Text('Sign in with Google'),
                    ],
                  )),
              ElevatedButton(
                  onPressed: () async {
                    _auth.signInWithFacebook();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.black12;
                        return Colors.blue[900]; // Use the component's default.
                      },
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            'assets/facebook.png',
                            color: Colors.white,
                          )),
                      Text('Sign in with Facebook'),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                _error,
                style: TextStyle(color: Colors.red),
              )
            ]),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo[900],
          child: Icon(
            Icons.login,
          ),
          onPressed: () => widget.toggleView()),
    );
  }
}
