import 'dart:convert';
import 'package:animated_battery_gauge/battery_gauge.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'cell_2.dart';
import 'cell_3.dart';
import 'cell_4.dart';
import 'cell_5.dart';
import 'cell_6.dart';
import 'graph_1.dart';
import 'dart:async';
import 'package:animated_battery_gauge/animated_battery_gauge.dart';
import 'package:flutter/cupertino.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class tab1 extends StatefulWidget {
  const tab1({super.key});

  @override
  State<tab1> createState() => _tab1State();
}

class _tab1State extends State<tab1> {

  @override
  void initState() {
    super.initState();
  }

  SpeedDial buildSpeedDial(){
    return SpeedDial(
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
        SpeedDialChild( //speed dial child
          child: Icon(Icons.auto_graph_sharp),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          label: 'Graphical status of Cell 1',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>graph_1())),
        ),
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
          child: Icon(Icons.home_filled),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          label: 'Home',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Home())),
        ),
        //add more menu item childs here
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(title: Text("Status of Cell 1"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          tabs: [
            Tab(
              text: 'Home',
              icon: Icon(Icons.home),
            ),
            Tab(
              text: 'Homesdsddfffdfdffgsdd',
              icon: Icon(Icons.home),
            ),
            Tab(
              text: 'Cell 4',
              icon: Icon(Icons.home),
            ),
            Tab(
              text: 'Home',
              icon: Icon(Icons.home),
            )
          ],
        ),
      ),
      body: TabBarView(
        children: [Home(),cell_2(),cell_4()],
      ),





      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          SizedBox(
            width: 300,
            height:70,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 0,
              onPressed: ()
              {
                null;
              },
              child: Builder(
                builder: (context){
                  if(volt1==0 && temp1==0 && soc1==0 && soh1==0)
                  {
                    return Text('Comment: Please wait until loading or Check your internet connection.',style: TextStyle(color: Colors.black,fontSize: 15),);
                  }
                  else if(temp1>=45)
                  {
                    return Text('Comment: Temperature is Too High remove charger.',style: TextStyle(color: Colors.black,fontSize: 20),);
                  }
                  else if(soh1<50){
                    return Text('Comment: SOH of cell 1 is too Low, replace Cell 1.',style: TextStyle(color: Colors.black,fontSize: 20),);
                  }
                  else if(soc1<30){
                    return Text('Comment: Low charge, please Connect charger.',style: TextStyle(color: Colors.black,fontSize: 20),);
                  }
                  else if(soc1==100){
                    return Text('Comment: Full charge, please Remove charger.',style: TextStyle(color: Colors.black, fontSize: 20),);
                  }
                  else{
                    return Text('Comment: No issues, Keep charging.',style: TextStyle(color: Colors.black,fontSize: 23),);
                  }
                },
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: ()
            {},
            child: buildSpeedDial(),
          ),
        ],
      ),
    );
  }
}







