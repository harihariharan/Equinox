import 'dart:convert';
import 'package:animated_battery_gauge/battery_gauge.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'cell_1.dart';
import 'cell_2.dart';
import 'cell_4.dart';
import 'cell_5.dart';
import 'cell_6.dart';
import 'graph_3.dart';
import 'dart:async';
import 'package:animated_battery_gauge/animated_battery_gauge.dart';
import 'package:flutter/cupertino.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


Map voltResponse3 = {'zero': 0, 'one': 1, 'two': 2};
Map tempResponse3 = {'zero': 0, 'one': 1, 'two': 2};
Map socResponse3 = {'zero': 0, 'one': 1, 'two': 2};
Map sohResponse3 = {'zero': 0, 'one': 1, 'two': 2};
double volt3 = 0.0000;
double temp3 = 0.0000;
double soc3 = 0.0000;
double soh3 = 0.0000;
Timer? timer;


class cell_3 extends StatefulWidget {
  const cell_3({super.key});

  @override
  State<cell_3> createState() => _cell_3State();
}

class _cell_3State extends State<cell_3> {

  Future Voltage () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2295970/fields/3.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        voltResponse3 = json.decode(response.body);
        volt3 = double.parse(voltResponse3['feeds'][0]["field3"]);
        //print(volt3);
      });
    }
  }

  Future Temperature () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2310566/fields/3.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        tempResponse3 = json.decode(response.body);
        temp3 = double.parse(tempResponse3['feeds'][0]["field3"]);
       // print(temp3);
      });
    }
  }

  Future Soc () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2295973/fields/3.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        socResponse3 = json.decode(response.body);
        soc3 = double.parse(socResponse3['feeds'][0]["field3"]);
        //print(soc3);
      });
    }
  }

  Future Soh () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2310585/fields/3.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        sohResponse3 = json.decode(response.body);
        soh3 = double.parse(sohResponse3['feeds'][0]["field3"]);
       // print(soh3);
      });
    }
  }

  Future gauge() async{
    key.currentState!.updateSpeed(temp3);
    speedNotifier.value = temp3;
  }

  final speedNotifier = ValueNotifier<double>(10);
  final key = GlobalKey<KdGaugeViewState>();

  @override
  void initState() {
    Voltage();
    Temperature();
    Soc();
    Soh();
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) => Voltage());
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) => Temperature());
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) => Soc());
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) => Soh());
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) => gauge());
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
          label: 'Graphical status of Cell 3',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>graph_3())),
        ),
        // SpeedDialChild(
        //   child: Icon(Icons.battery_full_sharp),
        //   backgroundColor: Colors.green,
        //   foregroundColor: Colors.white,
        //   label: 'Cell 6',
        //   labelStyle: TextStyle(fontSize: 18.0),
        //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_6())),
        // ),
        // SpeedDialChild(
        //   child: Icon(Icons.battery_5_bar_sharp),
        //   foregroundColor: Colors.white,
        //   backgroundColor: Colors.green,
        //   label: 'Cell 5',
        //   labelStyle: TextStyle(fontSize: 18.0),
        //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_5())),
        // ),
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
          label: 'Cell 2',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_2())),
        ),
        SpeedDialChild(
          child: Icon(Icons.battery_2_bar_sharp),
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
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(title: Text("Status of Cell 3"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,),
      body: GestureDetector(
        onHorizontalDragUpdate: (dis) {
          if(dis.delta.dx > 0)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_2()));
          }
          else if(dis.delta.dx < 0)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_4()));
          }
        },
        // onVerticalDragUpdate: (dis1)
        // {
        //   if(dis1.delta.dy < 0)
        //   {
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>graph_3()));
        //   }
        // },
        onDoubleTap:()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>graph_3()));
        },
    child: Container(child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 35.0,right: 10.0, bottom: 10.0),
        child: GridView(
          //physics: NeverScrollableScrollPhysics(),
          children: [
          InkWell(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.battery_charging_full_sharp,size: 150,color: volt3<2.2 ? Colors.red : Color(0xff006400),),
                  Text(volt3==0 ? 'Loading\nVoltage' : volt3.toStringAsFixed(3)+' V\nVoltage',style: TextStyle(color: Colors.white,fontSize: 26, fontWeight: FontWeight.bold),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              // key.currentState!.updateSpeed(48);
              // speedNotifier.value = 48;
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(0xff006400),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 175,
                    height: 200,
                    padding: EdgeInsets.all(10),
                    child: KdGaugeView(
                      key: key,
                      minSpeed: 0,
                      maxSpeed: 100,
                      minMaxTextStyle: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold,),
                      speed: temp3,
                      speedTextStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                      animate: true,
                      duration: Duration(seconds: 2),
                      alertSpeedArray: [19, 35, 45],
                      alertColorArray: [Colors.green, Colors.deepOrange, Colors.red],
                      unitOfMeasurement: temp3==0 ? "\n\n\n\n    Loading\ntemperature" : "\n\n\n\nTemperature\n\t\t\t\t\t\t\t\t\t\u00B0C",
                      unitOfMeasurementTextStyle: const TextStyle(fontSize: 26,fontWeight: FontWeight.bold,),
                      gaugeWidth: 20,
                      fractionDigits: 2,
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(0xff006400),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: AnimatedBatteryGauge(
                      duration: Duration(seconds: 2),
                      value: soc3,
                      size: Size(150, 70),
                      borderColor: soc3<30 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                      valueColor: soc3<30 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                      hasText: false,
                      mode: BatteryGaugePaintMode.grid,
                    ),
                  ),
                  Text(soc3==0 ? '\nLoading\nState-of-Charge' :'\n'+soc3.toStringAsFixed(3)+' %\nState-of-Charge',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.battery_saver_sharp,size: 150,color: soh3<50 ? Colors.red : Color(0xff006400),),
                  Text(soh3==0 ? 'Loading\nState-of-Health' : soh3.toStringAsFixed(3)+'%\nState-of-Health',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)
                ],),
            ),
          ),
        ],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,mainAxisExtent: 300),
        ),
      ),
      ),
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
                  if(volt3==0 && temp3==0 && soc3==0 && soh3==0)
                  {
                    return Text('Comment: Please wait until loading or Check your internet connection.',style: TextStyle(color: Colors.black,fontSize: 15),);
                  }
                  else if(temp3>=45)
                  {
                    return Text('Comment: Temperature is Too High remove charger.',style: TextStyle(color: Colors.black,fontSize: 20),);
                  }
                  else if(soh3<50){
                    return Text('Comment: SOH of cell 3 is too Low, replace Cell 3.',style: TextStyle(color: Colors.black,fontSize: 20),);
                  }
                  else if(soc3<30){
                    return Text('Comment: Low charge, please Connect charger.',style: TextStyle(color: Colors.black,fontSize: 20),);
                  }
                  else if(soc3==100){
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







