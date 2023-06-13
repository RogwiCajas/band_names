import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'banda 1', votes: 5),
    Band(id: '2', name: 'banda 2', votes: 3),
    Band(id: '3', name: 'banda 3', votes: 4),
    Band(id: '4', name: 'banda 4', votes: 5),
    Band(id: '5', name: 'banda 5', votes: 2),
    Band(id: '6', name: 'banda 6', votes: 3),
  ];
  int pink1 = 0xffffc0cb;
  int pink2 = 0xffdb7093;
  int pink3 = 0xffffe4e1;

  int indice = 1000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Band Names",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(pink2),
        elevation: 1,
        onPressed: () => addNewBand(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget bandTile(Band band) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: Key(band.id),
      onDismissed: (direction) {
        print(band.id);
      },
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(15.00),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text("Eliminando"),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(pink2),
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        selectedColor: Colors.red,
        selectedTileColor: Color(pink3),
        onLongPress: () {},
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        //selected: indice == int.parse(band.id),
        trailing: Text(
          "${band.votes}",
          style: const TextStyle(color: Colors.grey, fontSize: 22),
        ),
        onTap: () {
          //indice = int.parse(band.id);
          //setState(() {});
        },
      ),
    );
  }

  addNewBand(BuildContext context) {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("New Band name: "),
              content: TextField(
                controller: textController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*$'))
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 3,
                  onPressed: () {
                    addBandToList(textController.text);
                  },
                  textColor: Colors.blue,
                  child: const Text("Add"),
                )
              ],
            );
          });
    }
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text("New Band Name:"),
            content: CupertinoTextField(
              controller: textController,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*$'))
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("add"),
                onPressed: () => addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text("dismiss"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }

  addBandToList(String name) {
    if (name.length > 1) {
      print(name);
      bands.add(Band(
        id: DateTime.now().toString(), //(bands.length + 1).toString(),
        name: name,
        votes: 5,
      ));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
