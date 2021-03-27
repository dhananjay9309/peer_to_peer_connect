import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline_chat/classes/general.dart';
import 'package:flutter_offline_chat/on_borad_screen.dart';
import 'package:flutter_offline_chat/routes.dart';
import 'package:flutter_offline_chat/screens/client_screen.dart';
import 'package:flutter_offline_chat/screens/find_servers.dart';
import 'package:flutter_offline_chat/screens/server_screen.dart';
import 'package:wifi_info_plugin/wifi_info_plugin.dart';
import 'package:wifi_iot/wifi_iot.dart';

void main() {
  runApp(FlutterOfflineChat());
}

class FlutterOfflineChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: General.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: OnBoardingPage(),
      initialRoute: RouteNames.onboard,
      navigatorObservers: [routeObserver],
      routes: routes,
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (_) => MainScreen()),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  WifiInfoWrapper _wifiObject;
  bool wifiState = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    WifiInfoWrapper wifiObject;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      wifiObject = await WifiInfoPlugin.wifiDetails;
    } on PlatformException {}
    if (!mounted) return;

    setState(() {
      _wifiObject = wifiObject;
    });
  }

  @override
  Widget build(BuildContext context) {
    String ipAddress =
        _wifiObject != null ? _wifiObject.ipAddress.toString() : "ip";
    String routerIp =
        _wifiObject != null ? _wifiObject.routerIp.toString() : "routerIp";
    String dns1 = _wifiObject != null ? _wifiObject.dns1.toString() : "dns1";
    String dns2 = _wifiObject != null ? _wifiObject.dns2.toString() : "dns2";
    String bssId = _wifiObject != null ? _wifiObject.bssId.toString() : "bssId";
    String ssid = _wifiObject != null ? _wifiObject.ssid.toString() : "ssid";
    String macAddress =
        _wifiObject != null ? _wifiObject.macAddress.toString() : "macAddress";
    String linkSpeed =
        _wifiObject != null ? _wifiObject.linkSpeed.toString() : "linkSpeed";
    String signalStrength = _wifiObject != null
        ? _wifiObject.signalStrength.toString()
        : "signalStrength";
    String frequency =
        _wifiObject != null ? _wifiObject.frequency.toString() : "frequency";
    String networkId =
        _wifiObject != null ? _wifiObject.networkId.toString() : "networkId";
    String connectionType = _wifiObject != null
        ? _wifiObject.connectionType.toString()
        : "connectionType";
    String isHiddenSSid = _wifiObject != null
        ? _wifiObject.isHiddenSSid.toString()
        : "isHiddenSSid";

    return Scaffold(
      appBar: AppBar(
        title: Text(General.appName),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.maxFinite,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Running on:' + ipAddress,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Please make sure WIFI is enabled!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green.shade900),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('Create Server'),
                leading: Icon(Icons.miscellaneous_services_sharp),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ServerScreen()),
                  )
                },
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('Find Users'),
                leading: Icon(Icons.search),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FindServers(wirelessInfo: _wifiObject)),
                  )
                },
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('Connect to User via IP Address'),
                leading: Icon(Icons.connect_without_contact),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientScreen()),
                  )
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              child: Column(
                children: [
                  Text(
                    "Device Details",
                    style: TextStyle(fontSize: 18),
                  ),
                  ListTile(
                    title: Text('Router Ip'),
                    subtitle: Text(routerIp),
                  ),
                  ListTile(
                    title: Text('DNS 1'),
                    subtitle: Text(dns1),
                  ),
                  ListTile(
                    title: Text('DNS 2'),
                    subtitle: Text(dns2),
                  ),
                  ListTile(
                    title: Text('bssId'),
                    subtitle: Text(bssId),
                  ),
                  ListTile(
                    title: Text('SSID'),
                    subtitle: Text(ssid),
                  ),
                  ListTile(
                    title: Text('Mac Address'),
                    subtitle: Text(macAddress),
                  ),
                  ListTile(
                    title: Text('Link Speed'),
                    subtitle: Text(linkSpeed),
                  ),
                  ListTile(
                    title: Text('Signal Strength'),
                    subtitle: Text(signalStrength),
                  ),
                  ListTile(
                    title: Text('Frequency'),
                    subtitle: Text(frequency),
                  ),
                  ListTile(
                    title: Text('NetworkId'),
                    subtitle: Text(networkId),
                  ),
                  ListTile(
                    title: Text('ConnectionType'),
                    subtitle: Text(connectionType),
                  ),
                  ListTile(
                    title: Text('SSID Hidden'),
                    subtitle: Text(isHiddenSSid),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
