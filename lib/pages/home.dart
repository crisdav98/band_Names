import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:brand_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 8),
    Band(id: '3', name: 'Héroes del Silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 5),
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Band Names",
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i], size),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band, Size size) {
    return Dismissible(
      onDismissed: (direccion) {
        print("direction: $direccion");
        // TODO: Llamar  borrado en el server
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Delete Band",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.05),
          ),
        ),
        color: Colors.redAccent,
      ),
      key: Key(band.id),
      child: ListTile(
        leading: CircleAvatar(
          // substring(0,2) coge los 2 primeros caracteres de la cadena
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          "${band.votes}",
          style: TextStyle(fontSize: size.width * 0.05),
        ),
        onTap: () {
          print("TAP EN LIST");
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    // Para Android
    if (Platform.isAndroid) {
      return showDialog(
          builder: (context) {
            return AlertDialog(
              title: Text("Add new Band"),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                    textColor: Colors.blue,
                    child: Text("Add"),
                    onPressed: () => addBand(textController.text))
              ],
            );
          },
          context: context);
    }
    // Para IOS
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text("Add new Band"),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Add"),
                  onPressed: () => addBand(textController.text)),
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text("Dismiis"),
                  onPressed: () => Navigator.pop(context)),
            ],
          );
        });
  }

  void addBand(String name) {
    if (name.length > 1) {
      setState(() {
        this.bands.add(
            Band(id: (this.bands.length + 1).toString(), name: name, votes: 0));
      });
    }
    Navigator.pop(context);
  }
}
