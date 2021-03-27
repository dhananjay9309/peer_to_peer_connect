import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline_chat/classes/client.dart';
import 'package:flutter_offline_chat/classes/date_utils.dart';
import 'package:flutter_offline_chat/classes/general.dart';
import 'package:image_picker/image_picker.dart';

class ClientScreen extends StatefulWidget {
  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {

  Client client;
  List<String> serverLogs = [];
  TextEditingController controller = TextEditingController();
  var ipAddressController = TextEditingController();
  var nameController = TextEditingController();
  List<Socket> sockets = [];
  String selectedServerIp;
  String timeStamp = "";
  File _image;
  File _newImage;
  final picker = ImagePicker();
  String base64test;
  Uint8List bytes1;


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() async {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        final bytes = await File(_image.path).readAsBytes();
        String base64Encode(List<int> bytes) => base64.encode(bytes);
        // final bytes = File(_image).readAsBytesSync();

        print(base64Encode(bytes));
        base64test=base64Encode(bytes);
        client.write("([])"+base64test);
        String temp="([])"+base64test;
        client.write(
            '${DateTime.now().microsecondsSinceEpoch}:Client: $temp');
        this.onData(Uint8List.fromList(
            '${DateTime.now().microsecondsSinceEpoch}:Client: $temp'
                .codeUnits));
        for (Socket socket in sockets) {
          socket.write(
              '${DateTime.now().microsecondsSinceEpoch}:Client: $temp');
        }
        bytes1 = base64.decode(base64test);
        // final decodedBytes = base64Decode(base64test);
        //
        // _newImage  = File(Directory.current.path);
        // _newImage.writeAsBytesSync(decodedBytes);
        setState(() {
        });

      } else {
        print('No image selected.');
      }
    });
  }

  initState() {
    super.initState();
    client = Client(
      hostname: "192.168.1.46",
      port: General.defaultServerPort,
      onData: this.onData,
      onError: this.onError,
    );
    ipAddressController = TextEditingController(text: selectedServerIp);
  }

  onData(Uint8List data) {
    // timeStamp=
    if (timeStamp != String.fromCharCodes(data).split(":").elementAt(0)) {
      timeStamp = String.fromCharCodes(data).split(":").elementAt(0);
      print(String.fromCharCodes(data));
      serverLogs.add(
          "${String.fromCharCodes(data).split(":").elementAt(1)}: ${String.fromCharCodes(data).split(":").elementAt(2)}");
      setState(() {});
    }
  }

  onError(dynamic error) {
    print(error);
  }

  dispose() {
    controller.dispose();
    client.disconnect();
    super.dispose();
  }

  _connectToServer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: TextField(
            style: TextStyle(color: Colors.black),
            controller: ipAddressController,
            decoration: InputDecoration(
              hintText: "Enter an ip address",
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.black),
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.connect_without_contact,
                  size: 25,
                  color: Colors.green[900],
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: RaisedButton(
            color: Colors.purple,
            child: Text(
              !client.connected ? 'Connect' : 'Disconnect',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(ipAddressController);
              client.hostname = ipAddressController.text;
              if (client.connected) {
                await client.disconnect();
                this.serverLogs.clear();
              } else {
                await client.connect();
              }
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  changeName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: TextField(
            style: TextStyle(color: Colors.black),
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Enter your name",
              labelText: "Name",
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.black),
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.connect_without_contact,
                  size: 25,
                  color: Colors.green[900],
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: RaisedButton(
            color: Colors.purple,
            child: Text(
              !client.connected ? 'Connect' : 'Disconnect',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(ipAddressController);
              client.hostname = ipAddressController.text;
              if (client.connected) {
                await client.disconnect();
                this.serverLogs.clear();
              } else {
                await client.connect();
              }
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  _sendMessage() {
    client.write(
        '${DateTime.now().microsecondsSinceEpoch}:Client: ${controller.text}');
    this.onData(Uint8List.fromList(
        '${DateTime.now().microsecondsSinceEpoch}:Client: ${controller.text}'
            .codeUnits));
    for (Socket socket in sockets) {
      socket.write(
          '${DateTime.now().microsecondsSinceEpoch}:Client: ${controller.text}');
    }
    controller.text = "";
    if (FocusScope.of(context).isFirstFocus) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  _chat() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: serverLogs.map((String log) {
          return Row(
            children: [
              log.split(":").elementAt(0) == "Client"
                  ? Expanded(
                child: Container(
                  // color: Colors.redAccent,
                ),
              )
                  : SizedBox(),
              Padding(
                padding: EdgeInsets.all(5),
                child: log.split(":").elementAt(0) != "Client"
                    ? Bubble(
                  margin: BubbleEdges.only(top: 10),
                  nip: BubbleNip.leftBottom,
                  color: Colors.purple.shade300,
                  child: log.contains("([])")? Image.memory(base64.decode(log.split("([])").last.substring(0,100),),height: 200,width: 200,):Text(log.split(":").elementAt(1),
                      style:
                      TextStyle(color: Colors.white, fontSize: 17)),
                )
                    : Bubble(
                  margin: BubbleEdges.only(top: 10),
                  nip: BubbleNip.rightTop,
                  color: Colors.purple.shade700,
                  child: log.contains("([])")? Image.memory(base64.decode(log.split("([])").last,),height: 200,width: 200,):Text(log.split(":").elementAt(1),
                      style:
                      TextStyle(color: Colors.white, fontSize: 17)),
                ),
              ),
              log.split(":").elementAt(0) != "Client"
                  ? Expanded(
                child: Container(
                  // color: Colors.redAccent,
                ),
              )
                  : SizedBox(),
            ],
          );
        }).toList(),
      ),
    );
  }

  _messageSender() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      height: 80,
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          // GestureDetector(
          //   onTap:(){
          //     getImage();
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(right:15.0),
          //     child: Container(
          //         color: Colors.grey.shade200,
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Icon(Icons.photo_camera),
          //         )),
          //   ),
          // ),
          Flexible(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter your message.',
                      ),
                      controller: controller,
                    ),),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: MaterialButton(
              onPressed: () => controller.text = "",
              minWidth: 30,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Icon(Icons.clear, color: Colors.grey),
            ),
          ),
          Flexible(
            flex: 1,
            child: MaterialButton(
              onPressed: () => _sendMessage(),
              minWidth: 30,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Icon(Icons.send, color: Colors.purple),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _args = ModalRoute.of(context).settings.arguments as dynamic;
    if (_args != null) {
      selectedServerIp = _args['selectedServerIp'] ?? null;
      setState(() {
        ipAddressController.text = selectedServerIp;
        client.hostname = selectedServerIp;
        try {
          client.connect();
          client.connected = true;
        } catch (e) {
          client.connected = true;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Connect to User'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          _connectToServer(),
          // _connectToServer(),

          _chat(),
          if (client.connected) _messageSender(),
        ],
      ),
    );
  }
}
