import 'package:flutter/material.dart';
import 'package:cyberdeck_helper/rules.dart';

class _ViewConditionMonitorState extends State<ViewConditionMonitor> {
  DeckConfig config;

  _ViewConditionMonitorState({@required this.config});

  Widget _row(int maxBoxes, int start) {
    List<Widget> boxes = [_button(maxBoxes, start)];
    if (start + 1 <= maxBoxes) {
      boxes.add(_button(maxBoxes, start + 1));
    }
    if (start + 2 <= maxBoxes) {
      boxes.add(_button(maxBoxes, start + 2));
    }
    if (boxes.length == 3) {
      boxes.add(
        Text(
          ((start / 3 * -1).ceil() - 1).toString(),
          style: TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: 35.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: boxes,
      ),
    );
  }

  Widget _button(int maxBoxes, int index) => InkWell(
        child: Row(
          children: <Widget>[
            Icon(
              config.conditionMonitor > index ? Icons.warning : Icons.done,
              color:
                  config.conditionMonitor > index ? Colors.red : Colors.green,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'Box $index',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            config.conditionMonitor = index + 1;
          });
        },
      );

  @override
  Widget build(BuildContext context) {
    final rating = config.deck != null
        ? int.parse(config.deck.split(':')[0].split(' ')[1])
        : 0;
    final maxBoxes = (rating / 2).ceil() + 8;
    debugPrint('Max boxes is $maxBoxes; that is ${(maxBoxes / 3).ceil()} rows');
    final rows = new List<int>.generate((maxBoxes / 3).ceil(), (i) => i)
        .map((i) => _row(maxBoxes, i * 3 + 1))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Condition Monitor'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
        child: Column(
          children: new List.from([
            RaisedButton(
              child: Container(
                decoration: BoxDecoration(color: Colors.green),
                child: Text(
                  'Clear all damage',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              ),
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                setState(() {
                  config.conditionMonitor = 0;
                });
              },
            ),
          ])
            ..addAll(rows),
        ),
      ),
    );
  }
}

class ViewConditionMonitor extends StatefulWidget {
  final DeckConfig config;

  ViewConditionMonitor({Key key, @required this.config}) : super(key: key);

  @override
  _ViewConditionMonitorState createState() =>
      _ViewConditionMonitorState(config: this.config);
}
