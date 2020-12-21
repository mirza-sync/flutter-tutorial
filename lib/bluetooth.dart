import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import './widgets.dart';

class FlutterBlueApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLE Demo',
       theme: ThemeData(
         primarySwatch: Colors.blue,
       ),
       home: HomePage(title: 'Flutter BLE Demo'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final String title;
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();

  void _addDeviceToList(BluetoothDevice device) {
    if(!devicesList.contains(device)) {
      setState(() {
        devicesList.add(device);
      });
    }
  }

  @override
 void initState() {
   super.initState();
   widget.flutterBlue.connectedDevices
       .asStream()
       .listen((List<BluetoothDevice> devices) {
     for (BluetoothDevice device in devices) {
       _addDeviceToList(device);
     }
   });
   widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
     for (ScanResult result in results) {
       _addDeviceToList(result.device);
     }
   });
   widget.flutterBlue.startScan();
 }

  ListView _buildListViewOfDevices() {
   List<Container> containers = new List<Container>();
   for (BluetoothDevice device in devicesList) {
     containers.add(
       Container(
         height: 50,
         child: Row(
           children: <Widget>[
             Expanded(
               child: Column(
                 children: <Widget>[
                   Text(device.name == '' ? '(unknown device)' : device.name),
                   Text(device.id.toString()),
                 ],
               ),
             ),
             FlatButton(
               color: Colors.blue,
               child: Text(
                 'Connect',
                 style: TextStyle(color: Colors.white),
               ),
               onPressed: () {},
             ),
           ],
         ),
       ),
     );
   }
 
   return ListView(
     padding: const EdgeInsets.all(8),
     children: <Widget>[
       ...containers,
     ],
   );
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(widget.title),
       ),
       body:  _buildListViewOfDevices(),
    );
  }
}