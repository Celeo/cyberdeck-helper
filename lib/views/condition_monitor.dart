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
              config.conditionMonitor > index
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Condition Monitor'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
        child: Column(
          /*
            Need a number of rows equal to (maxBoxes / 3).ceil()
            Each row has up to 3 boxes, capping out at maxBoxes
            Each row needs to start at i, and go to i + 3, which is where the next row starts
          */
          children: new List<int>.generate((maxBoxes / 3).ceil(), (i) => i)
              .map((i) => _row(maxBoxes, i * 3 + 1))
              .toList(),
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
