import 'dart:convert';
import 'package:animated_battery_gauge/battery_gauge.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'cell_1.dart';
import 'cell_2.dart';
import 'cell_3.dart';
import 'cell_4.dart';
import 'cell_6.dart';
import 'graph_5.dart';
import 'dart:async';
import 'package:animated_battery_gauge/animated_battery_gauge.dart';
import 'package:flutter/cupertino.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


Map voltResponse5 = {'zero': 0, 'one': 1, 'two': 2};
Map tempResponse5 = {'zero': 0, 'one': 1, 'two': 2};
Map socResponse5 = {'zero': 0, 'one': 1, 'two': 2};
Map sohResponse5 = {'zero': 0, 'one': 1, 'two': 2};
double volt5 = 0.0000;
double temp5 = 0.0000;
double soc5 = 0.0000;
double soh5 = 0.0000;
Timer? timer;


class cell_5 extends StatefulWidget {
  const cell_5({super.key});

  @override
  State<cell_5> createState() => _cell_5State();
}

class _cell_5State extends State<cell_5> {

  Future Voltage () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2295970/fields/5.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        voltResponse5 = json.decode(response.body);
        volt5 = double.parse(voltResponse5['feeds'][0]["field5"]);
        //print(volt5);
      });
    }
  }

  Future Temperature () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2310566/fields/5.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        tempResponse5 = json.decode(response.body);
        temp5 = double.parse(tempResponse5['feeds'][0]["field5"]);
       // print(temp5);
      });
    }
  }

  Future Soc () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2295973/fields/5.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        socResponse5 = json.decode(response.body);
        soc5 = double.parse(socResponse5['feeds'][0]["field5"]);
      //  print(soc5);
      });
    }
  }

  Future Soh () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2310585/fields/5.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        sohResponse5 = json.decode(response.body);
        soh5 = double.parse(sohResponse5['feeds'][0]["field5"]);
      //  print(soh5);
      });
    }
  }

  Future gauge() async{
    key.currentState!.updateSpeed(temp5);
    speedNotifier.value = temp5;
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
          label: 'Graphical status of Cell 5',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>graph_5())),
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
          label: 'Cell 4',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_4())),
        ),
        SpeedDialChild( //speed dial child
          child: Icon(Icons.battery_4_bar_sharp),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          label: 'Cell 3',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_3())),
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
      appBar: AppBar(title: Text("Status of Cell 5"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,),
      body: GestureDetector(
        onHorizontalDragUpdate: (dis) {
          if(dis.delta.dx > 0)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_4()));
          }
          else if(dis.delta.dx < 0)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_6()));
          }
        },
        // onVerticalDragUpdate: (dis1)
        // {
        //   if(dis1.delta.dy < 0)
        //   {
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>graph_5()));
        //   }
        // },
        onDoubleTap:()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>graph_5()));
        },
    child: Container(child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 35.0,right: 10.0, bottom: 10.0),
        child: GridView(
          //physics: NeverScrollableScrollPhysics(),
          children: [
          InkWell(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.battery_charging_full_sharp,size: 150,color: volt5<2.2 ? Colors.red : Color(0xff006400),),
                  Text(volt5==0 ? 'Loading\nVoltage' : volt5.toStringAsFixed(3)+' V\nVoltage',style: TextStyle(color: Colors.white,fontSize: 26, fontWeight: FontWeight.bold),)
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
                      speed: temp5,
                      speedTextStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                      animate: true,
                      duration: Duration(seconds: 2),
                      alertSpeedArray: [19, 35, 45],
                      alertColorArray: [Colors.green, Colors.deepOrange, Colors.red],
                      unitOfMeasurement: temp5==0 ? "\n\n\n\n    Loading\ntemperature" : "\n\n\n\nTemperature\n\t\t\t\t\t\t\t\t\t\u00B0C",
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
                      value: soc5,
                      size: Size(150, 70),
                      borderColor: soc5<30 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                      valueColor: soc5<30 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                      hasText: false,
                      mode: BatteryGaugePaintMode.grid,
                    ),
                  ),
                  Text(soc5==0 ? '\nLoading\nState-of-Charge' :'\n'+soc5.toStringAsFixed(3)+' %\nState-of-Charge',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)
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
                  Icon(Icons.battery_saver_sharp,size: 150,color: soh5<50 ? Colors.red : Color(0xff006400),),
                  Text(soh5==0 ? 'Loading\nState-of-Health' : soh5.toStringAsFixed(3)+'%\nState-of-Health',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)
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
                  if(volt5==0 && temp5==0 && soc5==0 && soh5==0)
                  {
                    return Text('Comment: Please wait until loading or Check your internet connection.',style: TextStyle(color: Colors.black,fontSize: 15),);
                  }
                  else if(temp5>=45)
                  {
                    return Text('Comment: Temperature is Too High remove charger.',style: TextStyle(color: Colors.black,fontSize: 20),);
                  }
                  else if(soh5<50){
                    return Text('Comment: SOH of cell 5 is too weak, replace Cell 5.',style: TextStyle(color: Colors.black,fontSize: 20),);
                  }
                  else if(soc5<30){
                    return Text('Comment: Low charge, please Connect charger.',style: TextStyle(color: Colors.black,fontSize: 20),);
                  }
                  else if(soc5==100){
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







