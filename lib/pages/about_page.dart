import 'package:covid19/utils/app_style.dart';
import 'package:flutter/material.dart';
class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        backgroundColor: AppStyle.bg,
      ),
      body: Container(
        color: AppStyle.bg,
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
