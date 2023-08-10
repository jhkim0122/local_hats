import 'package:flutter/material.dart';

import '../data/GlobalData.dart';
import '../utils/WebNavigation.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}): super(key:key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage>{
  static const String routeName = "/";

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: WebNavigation(routeName),
        body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          scrollDirection: Axis.vertical,
          itemCount: menuList.length-1,
          itemBuilder: (BuildContext context, int index){
            return Container(height:60,
                margin:EdgeInsets.all(20),
                child:ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed(menuList[index+1].routeName),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, elevation:0.0, shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(4.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(menuList[index+1].label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:20)),)
            ));
          },
        )
    );
  }
}