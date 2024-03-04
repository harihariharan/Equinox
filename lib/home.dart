import 'dart:convert';
import 'package:analog_clock/analog_clock.dart';
import 'package:animated_battery_gauge/battery_gauge.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';
import 'package:http/http.dart' as http;
import 'cell_1.dart';
import 'cell_2.dart';
import 'cell_3.dart';
import 'cell_4.dart';
import 'cell_5.dart';
import 'cell_6.dart';
import 'contributor.dart';
import 'dart:async';
import 'package:animated_battery_gauge/animated_battery_gauge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/services.dart';


Map TimeResponse1 = {'zero': 0, 'one': 1, 'two': 2};
Map tempResponse1 = {'zero': 0, 'one': 1, 'two': 2};
Map socResponse1 = {'zero': 0, 'one': 1, 'two': 2};
Map voltResponse1 = {'zero': 0, 'one': 1, 'two': 2};
Map sohResponse1 = {'zero': 0, 'one': 1, 'two': 2};
double volt1 = 0.0000;
double volt2 = 0.0000;
double volt3 = 0.0000;
double volt4 = 0.0000;
double volt5 = 0.0000;
double volt6 = 0.0000;
double overall_volt = 0.0000;
double time1 = 0.0000;
double time_hr = 0.0000;
double time_min = 0.0000;
double time_sec = 0.0000;
double temp1 = 0.0000;
double soc1 = 0.0000;
double soc2 = 0.0000;
double soc3 = 0.0000;
double soc4 = 0.0000;
double soc5 = 0.0000;
double soc6 = 0.0000;
double overall_soc = 0.0000;
double soh1 = 0.0000;
String timing="0";
String finalEmail="0";
Timer? timer;


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future Time () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2407915/fields/1.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        TimeResponse1 = json.decode(response.body);
        time1 = double.parse(TimeResponse1['feeds'][0]["field1"]);
        time_hr = (time1/3600).floorToDouble();
        time_min = (time1/60).floorToDouble()-(time_hr*60);
        time_sec = time1-(time_min*60)-(time_hr*60*60);
        timing = time_hr.toStringAsFixed(0).padLeft(2,'0')+"Hr : "+time_min.toStringAsFixed(0).padLeft(2,'0')+"Min : "+time_sec.toStringAsFixed(0).padLeft(2,'0')+"Sec";
        //print(timing);
      });
    }
  }

  Future Temperature () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2295973/fields/7.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        tempResponse1 = json.decode(response.body);
        temp1 = double.parse(tempResponse1['feeds'][0]["field7"]);
       // print(temp1);
      });
    }
  }

  Future Soc () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2295973/feeds.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        socResponse1 = json.decode(response.body);
        soc1 = double.parse(socResponse1['feeds'][0]["field1"]);
        soc2 = double.parse(socResponse1['feeds'][0]["field2"]);
        soc3 = double.parse(socResponse1['feeds'][0]["field3"]);
        soc4 = double.parse(socResponse1['feeds'][0]["field4"]);
        // soc5 = double.parse(socResponse1['feeds'][0]["field5"]);
        // soc6 = double.parse(socResponse1['feeds'][0]["field6"]);
        // overall_soc = (soc1*0.16667)+(soc2*0.16667)+(soc3*0.16667)+(soc4*0.16667)+(soc5*0.16667)+(soc6*0.16667);
        overall_soc = (soc1*0.25)+(soc2*0.25)+(soc3*0.25)+(soc4*0.25);
        //print(overall_soc);
      });
    }
  }

  Future Volt () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2295970/feeds.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        voltResponse1 = json.decode(response.body);
        volt1 = double.parse(voltResponse1['feeds'][0]["field1"]);
        volt2 = double.parse(voltResponse1['feeds'][0]["field2"]);
        volt3 = double.parse(voltResponse1['feeds'][0]["field3"]);
        volt4 = double.parse(voltResponse1['feeds'][0]["field4"]);
        // volt5 = double.parse(voltResponse1['feeds'][0]["field5"]);
        // volt6 = double.parse(voltResponse1['feeds'][0]["field6"]);
        overall_volt = volt1+volt2+volt3+volt4;
        //print(overall_soc);
      });
    }
  }

  Future Soh () async{
    http.Response response;
    response = await http.get(Uri.parse("https://api.thingspeak.com/channels/2310585/fields/1.json?results=1"));
    if(response.statusCode == 200)
    {
      setState(() {
        //stringResponse = response.body;
        sohResponse1 = json.decode(response.body);
        soh1 = double.parse(sohResponse1['feeds'][0]["field1"]);
        //print(soh1);
      });
    }
  }

  Future getValidationData() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('Roll number');
    setState(() {
      finalEmail = obtainedEmail!;
    });
   // print(finalEmail);
  }

  Future gauge() async{
    key.currentState!.updateSpeed(temp1);
    speedNotifier.value = temp1;
  }

  Future<bool> showExitPopup(context) async{
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to exit?", style:TextStyle(color: Colors.black, fontSize: 18) ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                           // print('yes selected');
                            SystemNavigator.pop();
                            //exit(0);
                          },
                          child: Text("Yes", style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print('no selected');
                              Navigator.of(context).pop();
                            },
                            child: Text("No", style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  final speedNotifier = ValueNotifier<double>(10);
  final key = GlobalKey<KdGaugeViewState>();

  @override
  void initState() {
    getValidationData();
    Time();
    Temperature();
    Soc();
    Soh();
    Volt();
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) => Time());
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) => Temperature());
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) => Soc());
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) => Soh());
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) => Volt());
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
          child: Icon(Icons.people_sharp),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          label: 'Contributors',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>contri())),
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
        //add more menu item childs here
      ],
    );
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
      drawer: NavBar(),
      appBar: AppBar(title: Text("Welcome Home, $finalEmail"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,),
      body: GestureDetector(
      onPanUpdate: (dis) {
    if(dis.delta.dx > 0)
    {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>contri()));
    }
    else if(dis.delta.dx < 0)
    {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_1()));
    }
    },
    child: Container(child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10.0,right: 10.0, bottom: 90.0),
        child: GridView(children: [
          InkWell(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 220,
                    height: 220,
                    padding: EdgeInsets.all(10),
                  child: AnalogClock(
                    decoration: BoxDecoration(
                        border: Border.all(width: 3.0, color: Color(0xff006400)),
                        color: Color(0xff006400),
                        shape: BoxShape.circle), // decoration
                    isLive: false,
                    hourHandColor: Colors.white,
                    minuteHandColor: Colors.white,
                    secondHandColor: Colors.red,
                    tickColor: Colors.white,
                    useMilitaryTime: false,
                    showSecondHand: true,
                    numberColor: Colors.white,
                    showNumbers: true,
                    textScaleFactor: 1.5,
                    showTicks: true,
                    showDigitalClock: true,
                    digitalClockColor: Colors.white,
                    datetime: DateTime.now(),
                  ),),
                  Text(timing+"\n left to balance the cells",style: TextStyle(color: Colors.white,fontSize: 23, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      ],),
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
                      value: overall_soc,
                      size: Size(300, 130),
                      borderColor: CupertinoColors.white,
                      valueColor: overall_soc<50 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                      hasText: false,
                      textStyle: TextStyle(color: Color(0xff006400),fontSize: 36,),
                      mode: BatteryGaugePaintMode.grid,
                    ),
                  ),
                  Text(overall_soc==0 ? '\nLoading\nState-of-Charge of the battery' : '\n'+overall_soc.toStringAsFixed(3)+' %\nState-of-Charge of the battery',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)
                ],
              ),
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
                    width: 250,
                    height: 250,
                    padding: EdgeInsets.only(bottom: 20),
                    child: KdGaugeView(
                      key: key,
                      minSpeed: 0,
                      maxSpeed: 100,
                      minMaxTextStyle: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold,),
                      speed: temp1,
                      speedTextStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                      animate: true,
                      duration: Duration(seconds: 2),
                      alertSpeedArray: [19, 35, 45],
                      alertColorArray: [Colors.green, Colors.deepOrange, Colors.red],
                      unitOfMeasurement: temp1==0 ? "\n\n\n\n\t             Loading\nTemperature of battery" : "\n\n\n\n\nTemperature of battery\n              \t\tin \u00B0C",
                      unitOfMeasurementTextStyle: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),
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
                  Icon(Icons.battery_charging_full_sharp,size: 200,color: overall_volt<10 ? Colors.red : Colors.green,),
                  Text(overall_volt==0 ? 'Loading\nVoltage of the battery' : overall_volt.toStringAsFixed(3)+' V\nVoltage of the battery',style: TextStyle(color: Colors.white,fontSize: 26, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(0xff006400),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ Container(child: Center(child: Text("SOC level of individual cells",style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),),),
              Container(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: AnimatedBatteryGauge(
                      duration: Duration(seconds: 2),
                      value: soc1,
                      size: Size(70, 150),
                      borderColor: soc1<50 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                      valueColor: soc1<50 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                      hasText: true,
                      textStyle: TextStyle(color: Colors.black,fontSize: 23,),
                      mode: BatteryGaugePaintMode.grid,
                    ),
                  ),
                  AnimatedBatteryGauge(
                    duration: Duration(seconds: 2),
                    value: soc2,
                    size: Size(70, 150),
                    borderColor: soc2<50 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                    valueColor: soc2<50 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                    hasText: true,
                    textStyle: TextStyle(color: Colors.black,fontSize: 23,),
                    mode: BatteryGaugePaintMode.grid,
                  ),
                  AnimatedBatteryGauge(
                    duration: Duration(seconds: 2),
                    value: soc3,
                    size: Size(70, 150),
                    borderColor: soc3<50 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                    valueColor: soc3<50 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                    hasText: true,
                    textStyle: TextStyle(color: Colors.black,fontSize: 23,),
                    mode: BatteryGaugePaintMode.grid,
                  ),
                  AnimatedBatteryGauge(
                    duration: Duration(seconds: 2),
                    value: soc4,
                    size: Size(70, 150),
                    borderColor: soc4<50 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                    valueColor: soc4<50 ? CupertinoColors.destructiveRed : CupertinoColors.activeGreen,
                    hasText: true,
                    textStyle: TextStyle(color: Colors.black,fontSize: 23,),
                    mode: BatteryGaugePaintMode.grid,
                  ),
                  // Text(overall_soc==0 ? '\nLoading\nState-of-Charge' : overall_soc.toStringAsFixed(3)+' %\nState-of-Charge of the battery',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)
                ],
              ),
                ),
                Container(child: Center(child: Text("Cell 1        Cell 2        Cell 3        Cell 4",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),),),
            ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.battery_saver_sharp,size: 200,color: soh1<50 ? Colors.red : Color(0xff006400),),
                  Text(soh1==0 ? 'Loading\nState-of-Health of the battery' : soh1.toStringAsFixed(3)+'%\nState-of-Health of the battery',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)
                ],),
            ),
          ),
        ],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,mainAxisSpacing: 10,crossAxisSpacing: 10,mainAxisExtent: 300),
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
                  if(volt1==0 && temp1==0 && soc1==0 && soh1==0)
                  {
                    return Text('Comment: Please wait until loading or Check your internet connection.',style: TextStyle(color: Colors.black,fontSize: 15), );
                  }
                  else if(temp1>=45)
                  {
                    return Text('Comment: Temperature is Too High remove charger.',style: TextStyle(color: Colors.black,fontSize: 20),);
                  }
                  else if(soh1<50){
                    return Text('Comment: SOH of battery is too Low, replace the battery.',style: TextStyle(color: Colors.black,fontSize: 20),);
                  }
                  else if(soc1<45){
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
      ),
    );
  }
}







