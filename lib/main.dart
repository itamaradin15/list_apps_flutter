import 'dart:typed_data';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListAppsPage(),
      title: "List apps",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ListAppsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List apps flutter example"),
      ),
      body: ListAppsBody(),
    );
  }
}

class ListAppsBody extends StatefulWidget {
  @override
  _ListAppBodyState createState() => _ListAppBodyState();
}

class _ListAppBodyState extends State {
  List listApps = [];

  @override
  void initState() {
    super.initState();
    _getApp();
  }

   void _getApp() async{
    List _apps = await DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true, includeAppIcons: true, includeSystemApps: true);
    for(var app in _apps){
      var item = AppModel(
        title: app.appName,
        package: app.packageName,
        icon: app.icon,
      );
      listApps.add(item);
    }

    //reloading state
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listApps.length,
      itemBuilder: (context, int i) => Column(
        children: [
          new ListTile(
            leading: Image.memory(listApps[i].icon),
            title: new Text(listApps[i].title),
            subtitle: new Text(listApps[i].package),
            onTap: (){
              DeviceApps.openApp(listApps[i].package);
            },
          ),
        ],
      ),
    );
  }
}

class AppModel{
  final String title;
  final String package;
  final Uint8List icon;

  AppModel({
    this.title,
    this.package,
    this.icon
  });
}
