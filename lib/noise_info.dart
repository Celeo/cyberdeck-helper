import 'package:flutter/material.dart';

class ViewNoiseInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noise Info'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          children: <Widget>[
            Text(
                'Each level of noise adds a stacking -1 penalty to all Matrix tests.\n\n' +
                    'Noise from distance only applies once, but any applicable obstruction ' +
                    'modifiers can stack.',
                style: TextStyle(fontSize: 16.0)),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text('From distance:',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child:
                  Table(border: TableBorder.all(color: Colors.grey), children: [
                TableRow(children: [
                  _cell("Direct connection"),
                  _cell("0"),
                ]),
                TableRow(children: [
                  _cell("Less than 100m"),
                  _cell("0"),
                ]),
                TableRow(children: [
                  _cell("100m - 1,000m"),
                  _cell("1"),
                ]),
                TableRow(children: [
                  _cell("1,001 - 10,000m"),
                  _cell("3"),
                ]),
                TableRow(children: [
                  _cell("10,001m - 100,000m"),
                  _cell("5"),
                ]),
                TableRow(children: [
                  _cell("More than 100km"),
                  _cell("8"),
                ]),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text('Obstructions',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child:
                  Table(border: TableBorder.all(color: Colors.grey), children: [
                TableRow(children: [
                  _cell("Dense Foliage"),
                  _cell("1 per 5m"),
                ]),
                TableRow(children: [
                  _cell("Faraday Cage"),
                  _cell("No connection"),
                ]),
                TableRow(children: [
                  _cell("Fresh Water"),
                  _cell("1 per 10cm"),
                ]),
                TableRow(children: [
                  _cell("Jamming"),
                  _cell("Jamming test hits"),
                ]),
                TableRow(children: [
                  _cell("Metal-laced earth/wall"),
                  _cell("1 per 5m"),
                ]),
                TableRow(children: [
                  _cell("Salt Water"),
                  _cell("1 per 1cm"),
                ]),
                TableRow(children: [
                  _cell("Spam/static zone"),
                  _cell("Rating"),
                ]),
                TableRow(children: [
                  _cell("Wireless negation"),
                  _cell("Rating"),
                ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  _cell(String text) => Padding(
        padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 10.0),
        child: Text(text, style: TextStyle(fontSize: 16.0)),
      );
}
