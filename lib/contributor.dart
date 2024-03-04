import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'navbar.dart';
import 'home.dart';
import 'cell_1.dart';
import 'cell_2.dart';
import 'cell_3.dart';
import 'cell_4.dart';
import 'cell_5.dart';
import 'cell_6.dart';

class contri extends StatefulWidget {
  const contri({super.key});

  @override
  State<contri> createState() => _contriState();
}

class _contriState extends State<contri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(title: Text("Contributors: Team 10"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,),
      body: GestureDetector(
        onHorizontalDragUpdate: (dis) {
      if(dis.delta.dx > 0)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
      }
      else if(dis.delta.dx < 0)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
      }
    },
        onDoubleTap:()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
        },

    child: Container(child: Padding(
        padding: const EdgeInsets.only(left: 50.0, top: 10.0,right: 50.0, bottom: 10.0),
        child: GridView(children: [
          InkWell(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.green, width: 5),color: Colors.white,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/login_images/team-1.jpg',
                    width: 300,
                    height: 240,),
                 Text("Visionery\nHariharan J, 20BEE033\nFinal year EEE.",style: TextStyle(color: Color(0xff006400),fontSize: 20,fontWeight: FontWeight.bold,),textAlign: TextAlign.center)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              // key.currentState!.updateSpeed(48);
              // speedNotifier.value = 48;
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.green, width: 5), color: Colors.white,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/login_images/team-2.jpg',
                    width: 300,
                    height: 240,),
                  Text("Hustler\nJayanth S K, 20BEE039\nFinal year EEE.",style: TextStyle(color: Color(0xff006400),fontSize: 20,fontWeight: FontWeight.bold,),textAlign: TextAlign.center)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.green, width: 5), color: Colors.white,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/login_images/team-3.jpg',
                    width: 300,
                    height: 240,),
                  Text("Impacter\nVishnu M, 20BEE231\nFinal year EEE.",style: TextStyle(color: Color(0xff006400),fontSize: 20,fontWeight: FontWeight.bold,),textAlign: TextAlign.center)
                ],),
            ),
          ),
        ],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,mainAxisSpacing: 10,crossAxisSpacing: 10,mainAxisExtent: 350),
        ),
      ),
      ),
    ),

      floatingActionButton: SpeedDial( //Speed dial menu
      //marginBottom: 10, //margin bottom
      icon: Icons.menu, //icon on Floating action button
      activeIcon: Icons.close, //icon when menu is expanded on button
      backgroundColor: Colors.green, //background color of button
      foregroundColor: Colors.black, //font color, icon color in button
      activeBackgroundColor: Colors.redAccent, //background color when menu is expanded
      activeForegroundColor: Colors.white,
      // buttonSize: 56.0, //button size
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'), // action when menu opens
      onClose: () => print('DIAL CLOSED'), //action when menu closes

      elevation: 8.0, //shadow elevation of button
      shape: CircleBorder(), //shape of button

      children: [
        SpeedDialChild(
          child: Icon(Icons.battery_full_sharp),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          label: 'Cell 6',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_6())),
        ),
        SpeedDialChild(
          child: Icon(Icons.battery_5_bar_sharp),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          label: 'Cell 5',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_5())),
        ),
        SpeedDialChild( //speed dial child
          child: Icon(Icons.battery_4_bar_sharp),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          label: 'Cell 4',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_4())),
        ),
        SpeedDialChild(
          child: Icon(Icons.battery_3_bar_sharp),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          label: 'Cell 3',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_3())),
        ),
        SpeedDialChild(
          child: Icon(Icons.battery_2_bar_sharp),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          label: 'Cell 2',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_2())),
        ),
        SpeedDialChild(
          child: Icon(Icons.battery_1_bar_sharp),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          label: 'Cell 1',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_1())),
        ),
        SpeedDialChild(
          child: Icon(Icons.home_filled),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          label: 'Home',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Home())),
        ),

        //add more menu item childs here
      ],
    ),
    );
  }
}
