import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline_chat/classes/date_utils.dart';
import 'package:flutter_offline_chat/classes/server.dart';
import 'package:image_picker/image_picker.dart';

class ServerScreen extends StatefulWidget {
  @override
  _ServerScreenState createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> {
  Server server;
  List<String> serverLogs = [];
  File _image;
  File _newImage;
  final picker = ImagePicker();
  TextEditingController controller = TextEditingController();
  String base64test;
  Uint8List bytes1;


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        final bytes = await File(_image.path).readAsBytes();
        print(bytes.length);
        String base64Encode(List<int> bytes) => base64.encode(bytes);
        // final bytes = File(_image).readAsBytesSync();
        print(base64Encode(bytes).length);
        base64test=base64Encode(bytes);
        server.broadCast("([])"+base64test);
        bytes1 = base64.decode(base64test);
        // print(bytes1.length);
        // final decodedBytes = base64Decode(base64test);
        //
        // _newImage  = File(Directory.current.path);
        // _newImage.writeAsBytesSync(decodedBytes);
        setState(() {
        });

      } else {
        print('No image selected.');
      }
  }

  initState() {
    super.initState();

    server = Server(
      onData: this.onData,
      onError: this.onError,
    );
  }

  onData(Uint8List data) {
    // print(":dfsdfds");
    // print(data);
    serverLogs.add(
        "${String.fromCharCodes(data).split(":").elementAt(1)}: ${String.fromCharCodes(data).split(":").elementAt(2)}");

    setState(() {});
  }

  onError(dynamic error) {
    print(error);
  }

  dispose() {
    controller.dispose();
    server.stop();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     getImage();
      //   },
      // ),
      appBar: AppBar(
        title: Text('Create Server'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: confirmReturn,
        ),
      ),
      body: Column(
        children: <Widget>[
          // bytes1==null?SizedBox():Image.memory(bytes1),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                children: <Widget>[
                  _header(),
                  Divider(
                    height: 30,
                    thickness: 1,
                    color: Colors.black12,
                  ),
                  _chat(),
                ],
              ),
            ),
          ),
          _messageContainer(),
        ],
      ),
    );
  }
  confirmReturn() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("WARNING"),
          content: Text("Leaving this screen will disconnect the server"),
          actions: <Widget>[
            FlatButton(
              child: Text("Exit", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Cancel", style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            Text(
              "Server",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: server.running ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                padding: EdgeInsets.all(5),
                child: Text(
                  server.running ? 'ON' : 'OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        RaisedButton(
          color: server.running ? Colors.red : Colors.green,
          child: server.running
              ? Icon(
            Icons.stop,
            color: Colors.white,
          )
              : Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
          onPressed: () async {
            if (server.running) {
              await server.stop();
              this.serverLogs.clear();
            } else {
              await server.start();
            }
            setState(() {});
          },
        ),
      ],
    );
  }

  _messageContainer() {
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
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        // GestureDetector(
                        //   onTap:(){
                        //     getImage();
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(right:15.0),
                        //     child: Container(
                        //       color: Colors.grey.shade200,
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Icon(Icons.photo_camera),
                        //         )),
                        //   ),
                        // ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter your message.',
                            ),
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 2,
          ),
          MaterialButton(
            onPressed: () {
              controller.text = "";
            },
            minWidth: 30,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: Icon(
              Icons.clear,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          MaterialButton(
            onPressed: () {
              print(1);
              server.broadCast(controller.text);
              controller.text = "";
              if (FocusScope.of(context).isFirstFocus) {
                FocusScope.of(context).requestFocus(new FocusNode());
              }
            },
            minWidth: 10,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: Icon(
              Icons.send,
              color: Colors.purple,
            ),
          )
        ],
      ),
    );
  }

  _chat() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: serverLogs.map((String log) {
          return Row(
            children: [
              log.split(":").elementAt(0) == "Server"
                  ? Expanded(
                child: Container(
                  // color: Colors.redAccent,
                ),
              )
                  : SizedBox(),
              Padding(
                padding: EdgeInsets.all(5),
                child: log.split(":").elementAt(0) != "Server"
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
              log.split(":").elementAt(0) != "Server"
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
}
