import 'package:covid19/pages/history_page.dart';
import 'package:covid19/providers/country_provider.dart';
import 'package:covid19/providers/daily_provider.dart';
import 'package:covid19/providers/history_provider.dart';
import 'package:covid19/providers/home_provider.dart';
import 'package:covid19/providers/province_provider.dart';
import 'package:covid19/utils/app_style.dart';
import 'package:covid19/utils/fade_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'about_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateFormat fn = DateFormat("M-dd-yyyy");
  String _selectedLocation = "BR";
  String datetime = '2-14-2020';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    setState(() {
      datetime = fn.format(DateTime(now.year, now.month, now.day - 1));
    });

    Provider.of<CountryProvider>(context, listen: false).getCountryProvider();
    Provider.of<HistoryProvider>(context, listen: false).getHistory();
    Provider.of<DailyProvider>(context, listen: false)
        .getDailyProvider(datetime);
    Provider.of<ProvinceProvider>(context, listen: false)
        .getProvinceProvider(_selectedLocation);
    Provider.of<HomeProvider>(context, listen: false).getHomeProvider();

  }

  @override
  Widget build(BuildContext context) {
    DateFormat f = DateFormat("yyyy-MM-dd HH:mm:ss");
    final nf = NumberFormat("#,###");
    var home = Provider.of<HomeProvider>(context).home;
    var daily = Provider.of<DailyProvider>(context).daily;
    var province = Provider.of<ProvinceProvider>(context).province;
    var country = Provider.of<CountryProvider>(context).country;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'lib/images/covid19.png',
          height: 20.0,
        ),
        backgroundColor: AppStyle.bg,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  FadeRoute(page: AboutPage()),
                );
              })
        ],
      ),
      body: Container(
        color: AppStyle.bg,
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            if (home != null)
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Spacer(),
                      Icon(
                        Icons.timer,
                        color: AppStyle.txg,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        f.format(home?.lastUpdate),
                        style: TextStyle(color: AppStyle.txg),
                      )
                    ],
                  ),
                  titleWidget('Confirmed',
                      nf.format(home?.confirmed?.value) ?? '', AppStyle.txw),
                  titleWidget('Recovered',
                      nf.format(home?.recovered?.value) ?? '', AppStyle.txg),
                  titleWidget('Deaths', nf.format(home?.deaths?.value) ?? '',
                      AppStyle.txr),
                ],
              ),
            SizedBox(
              height: 20.0,
            ),
            Card(
              color: Color(0xff3b4F55),
              child: Column(
                children: <Widget>[
                  if (country != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Theme(
                          data: ThemeData(canvasColor: AppStyle.bgl),
                          child: DropdownButton(
                            items: country.countries.entries
                                .map<DropdownMenuItem<String>>(
                                    (MapEntry<String, String> e) =>
                                        DropdownMenuItem<String>(
                                          value: e.value,
                                          child: Text(
                                            e.key,
                                            style: TextStyle(
                                              color: AppStyle.txg,
                                            ),
                                          ),
                                        ))
                                .toList(),
                            value: _selectedLocation,
                            onChanged: (newvalue) {
                              print(newvalue);
                              setState(() {
                                _selectedLocation = newvalue;
                              });
                              Provider.of(context, listen: false)
                                  .getProvinceProvider(newvalue);
                            },
                            isExpanded: true,
                            hint: Text("Please Choose a Location"),
                            style: TextStyle(color: AppStyle.txg),
                          )),
                    ),
                  confirmDetail(
                      province?.confirmed?.value.toString(),
                      province?.recovered?.value?.toString(),
                      province?.deaths?.value?.toString())
                ],
              ),
            ),
            ListTile(
              title: Text('Historia do corona virus', style: AppStyle.stdtw),
              subtitle: Text('Acompanhe os casos no Brasil',
                  style: AppStyle.stdtr),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppStyle.txw,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HistoryPage()),
                );
              },
            ),
            Divider(color: AppStyle.txw),
            ListTile(
              title: Text('Daily Cases', style: AppStyle.stdtw),
              trailing: InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2020, 1, 1),
                        maxTime: DateTime(2020, 12, 31), onConfirm: (date) {
                      setState(() {
                        datetime = fn.format(date);
                        Provider.of<DailyProvider>(context, listen: false)
                            .getDailyProvider(datetime);
                      });
                    }, currentTime: DateTime.now());
                  },
                  child: Text('Change $datetime',
                      style: TextStyle(color: AppStyle.txg))),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget confirmDetail(confirm, recovered, death) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Confirmed', style: AppStyle.stdtw),
              Padding(
                padding: AppStyle.pv10,
                child: Text(confirm ?? '',
                    style: AppStyle.stdtb.copyWith(color: AppStyle.txw)),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Recovered', style: AppStyle.stdtw),
              Padding(
                padding: AppStyle.pv10,
                child: Text(recovered ?? '',
                    style: AppStyle.stdtb.copyWith(color: AppStyle.txg)),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Deaths', style: AppStyle.stdtw),
              Padding(
                padding: AppStyle.pv10,
                child: Text(death ?? '',
                    style: AppStyle.stdtb.copyWith(color: AppStyle.txr)),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget titleWidget(title, subtitle, color) {
    return ListTile(
      title: Text(title, style: AppStyle.stdtw),
      subtitle:
          Text(subtitle, style: AppStyle.subtitleMain.copyWith(color: color)),
    );
  }
}
