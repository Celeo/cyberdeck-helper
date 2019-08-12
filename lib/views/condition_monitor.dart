import 'package:flutter/material.dart';
import 'package:cyberdeck_helper/rules.dart';

class _ViewConditionMonitorState extends State<ViewConditionMonitor> {
  DeckConfig config;

  _ViewConditionMonitorState({@required this.config});

  Widget _button(int index) => Card(
        child: ListTile(
          leading: Icon(config.conditionMonitor <= index
              ? Icons.favorite
              : Icons.favorite_border),
          title: Text('Box $index'),
          onTap: () {
            setState(() {
              config.conditionMonitor = index;
            });
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    final rating = config.deck != null
        ? int.parse(config.deck.split(':')[0].split(' ')[1])
        : 0;
    final maxBoxes = (rating / 2).ceil() + 8;
    return Scaffold(
      appBar: AppBar(
        title: Text('Condition Monitor'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Center(
          child: ListView(
            children: new List<int>.generate(maxBoxes, (i) => i + 1)
                .map((i) => _button(i))
                .toList(),
          ),
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
