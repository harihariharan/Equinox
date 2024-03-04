import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'home.dart';
import 'dart:async';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override


  void initState() {
    // TODO: implement initState
    super.initState();

    Future getValidationData() async{
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var obtainedEmail = sharedPreferences.getString('Roll number');
      setState(() {
        finalEmail = obtainedEmail!;
      });
      //print(finalEmail);
    }

    Timer(Duration(seconds: 3), () {
      getValidationData().whenComplete(() async{
        Navigator.pushAndRemoveUntil<void>(context, MaterialPageRoute<void>(builder: (context)=> finalEmail == "0" ? LoginPage(): Home()),(Route<dynamic> route) => false,);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Image.asset(
              "assets/login_images/logo2.png",
              height: 120,
            ),
            Text(
              "Equinox",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'opensans',
                  fontSize: 32,
                  letterSpacing: 2),
            ),
            Text(
              "Powered by",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff006400),
                  fontFamily: 'opensans',
                  fontSize: 18,
                  letterSpacing: 1),
            ),
            Text(
              "Electrical and Electronics Engineering Team 10",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'opensans',
                  fontSize: 20,
                  letterSpacing: 1),
            ),

            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),

    );
  }
}


