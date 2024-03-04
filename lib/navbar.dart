import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login.dart';
import 'home.dart';
import 'cell_1.dart';
import 'cell_2.dart';
import 'cell_3.dart';
import 'cell_4.dart';
import 'cell_5.dart';
import 'cell_6.dart';
import 'contributor.dart';

class NavBar extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('$finalEmail',style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold,),),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/login_images/logo2.png',
                  width: 90,
                  height: 90,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Color(0xff001f3f),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                      'assets/login_images/image_2.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_filled, color: Color(0xff006400),),
            title: Text('Home', style: TextStyle(fontSize: 20),),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Home())),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.battery_1_bar_sharp, color: Color(0xff006400),),
            title: Text('Cell 1', style: TextStyle(fontSize: 20)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_1())),
          ),
          ListTile(
            leading: Icon(Icons.battery_2_bar_sharp, color: Color(0xff006400),),
            title: Text('Cell 2', style: TextStyle(fontSize: 20)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_2())),
          ),
          ListTile(
            leading: Icon(Icons.battery_3_bar_sharp, color: Color(0xff006400),),
            title: Text('Cell 3', style: TextStyle(fontSize: 20)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_3())),
          ),
          ListTile(
            leading: Icon(Icons.battery_4_bar_sharp, color: Color(0xff006400),),
            title: Text('Cell 4', style: TextStyle(fontSize: 20)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_4())),
          ),
          // ListTile(
          //   leading: Icon(Icons.battery_5_bar_sharp, color: Color(0xff006400),),
          //   title: Text('Cell 5', style: TextStyle(fontSize: 20)),
          //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_5())),
          // ),
          // ListTile(
          //   leading: Icon(Icons.battery_full_sharp, color: Color(0xff006400),),
          //   title: Text('Cell 6', style: TextStyle(fontSize: 20)),
          //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_6())),
          // ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people_sharp, color: Color(0xff006400),),
            title: Text('Contributors', style: TextStyle(fontSize: 20)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>contri())),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.web_sharp, color: Color(0xff006400),),
            title: Text('Wesite View', style: TextStyle(fontSize: 20)),
            onTap: () async{
              final Uri url = Uri.parse("https://harihariharan.github.io/Revolutionizing-Cell-Balancing");
              if(!await launchUrl(url)){
                print("Exception error");
              }
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout', style: TextStyle(fontSize: 20)),
            leading: Icon(Icons.exit_to_app, color: Color(0xff006400),),
            onTap: ()
            async{
          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('Roll number','0');
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            }
          ),
        ],
      ),
    );
  }
}