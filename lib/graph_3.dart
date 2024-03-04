import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_iframe/flutter_html_iframe.dart';
import 'navbar.dart';
import 'home.dart';
import 'cell_1.dart';
import 'cell_2.dart';
import 'cell_3.dart';
import 'cell_4.dart';
import 'cell_5.dart';
import 'cell_6.dart';
import 'graph_2.dart';
import 'graph_4.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class graph_3 extends StatelessWidget {
  final String htmlcontent = """
    <h2 style="text-align:center;color:#006400;">Voltage of Cell 3</h2>
    <iframe width="450" height="200" style="border: 1px solid #cccccc;width:900px;height:200px;overflow:auto;" src="https://thingspeak.com/channels/2295970/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=Cell+3+Voltage&type=line&xaxis=Time"></iframe>
    <h2 style="text-align:center;color:#006400;">State of Charge of Cell 3</h2>
    <iframe width="450" height="200" style="border: 1px solid #cccccc;width:900px;height:200px;overflow:auto;" src="https://thingspeak.com/channels/2295973/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=Cell+3+SOC&type=line&xaxis=Time"></iframe>
    <h2 style="text-align:center;color:#006400;">Temperature of Cell 3</h2>
     <iframe width="450" height="200" style="border: 1px solid #cccccc;width:900px;height:200px;overflow:auto;" src="https://thingspeak.com/channels/2310566/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=Cell+3+Tempature&type=line&xaxis=Time"></iframe>
    <h2 style="text-align:center;color:#006400;">State of Health of Cell 3</h2>
    <iframe width="450" height="200" style="border: 1px solid #cccccc;width:900px;height:200px;overflow:auto;" src="https://thingspeak.com/channels/2310585/charts/3?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&title=Cell+3+SOH&type=line&xaxis=Time&yaxis=State+of+Health"></iframe>
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(title: Text("Graphical status of Cell 3"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onHorizontalDragUpdate: (dis) {
          if(dis.delta.dx > 0)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>graph_2()));
          }
          else if(dis.delta.dx < 0)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>graph_4()));
          }
        },
        onDoubleTap:()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>cell_3()));
        },
        child:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Html(
                data: htmlcontent,
                extensions: [
                  IframeHtmlExtension(),
                ],
              ),
            ),
          ],
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
          SpeedDialChild( //speed dial child
            child: Icon(Icons.auto_graph_sharp),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            label: 'Graphical status of Cell 2',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>graph_2())),
          ),
          SpeedDialChild( //speed dial child
            child: Icon(Icons.auto_graph_sharp),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            label: 'Graphical status of Cell 4',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>graph_4())),
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