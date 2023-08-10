import 'package:flutter/material.dart';

import '../data/GlobalData.dart';

class WebNavigation extends StatelessWidget implements PreferredSizeWidget {
  final String currentPage;
  @override
  final Size preferredSize;
  WebNavigation(this.currentPage, {Key? key}) : preferredSize = Size.fromHeight(80), super(key:key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Container(
          margin: const EdgeInsets.fromLTRB(10, 30, 20, 10),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            direction: Axis.horizontal,
            children: [
              Icon(Icons.flutter_dash, color:Colors.deepOrange, size:50),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:[
              for(int index=0; index<menuList.length; index++)
                ElevatedButton(
                    onPressed: () => Navigator.of(context).popAndPushNamed(menuList[index].routeName),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation:0.0, shadowColor: Colors.transparent),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(menuList[index].label, style: TextStyle(fontSize: 24.0, color: currentPage == menuList[index].routeName ? Colors.deepOrange : Colors.black)),)
                )])
            ]
        )));
  }
  
}