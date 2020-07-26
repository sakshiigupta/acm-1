import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_screen_lock/lock_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  bool _canCheckBiometric=false;
  String _authorize = "Not authorized";
  LocalAuthentication authentication = LocalAuthentication();

//
//  Future<void> _checkBiometric()async{
//    bool canCheckBiometric = false;
//    try{
//      canCheckBiometric= await authentication.canCheckBiometrics;
//    }
//    on PlatformException catch(e){
//      print(e);
//    }
//    if(!mounted) return;
//
//    setState(() {
//      _canCheckBiometric=canCheckBiometric;
//    });
//
//  }

  Future<void> _authorizeNow() async {
    bool authorize = false;
    try {
      authorize = await authentication.authenticateWithBiometrics(
        localizedReason: "Scan your fingerprint",
        useErrorDialogs: true,
        stickyAuth: false,
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _authorize = authorize ? "Authorized" : "Not authorized";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepOrangeAccent, Colors.deepPurpleAccent],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

                Text(
                  'BIOMETRICS',
                  style: TextStyle(
                    //backgroundColor: Colors.tealAccent,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DancingScript',
                  ),
                ),

//          Text('can check biometric? : $_canCheckBiometric'),
//          FlatButton(
//            onPressed: _checkBiometric,
//            child: Text('check it now'),
//            color: Colors.deepOrangeAccent,
//          ),
              //Text('authorized? :$_authorize'),
              FlatButton(

                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.black),),
                onPressed: _authorizeNow,
                child: Text('authorize'),
                color: Colors.deepOrangeAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
