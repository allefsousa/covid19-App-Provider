import 'package:covid19/utils/app_style.dart';
import 'package:covid19/utils/fade_route.dart';
import 'package:flutter/material.dart';

import 'about_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('lib/images/covid19.png',height: 20.0,),
        backgroundColor: AppStyle.bg,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.info_outline),
              onPressed: (){
                Navigator.push(context, FadeRoute(page: AboutPage()),
                );
              })
        ],
      ),
      body: Center(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}