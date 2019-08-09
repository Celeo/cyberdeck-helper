import 'package:flutter/material.dart';

void main() => runApp(App());

const appName = 'Cyberdeck Helper';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePageState extends State<HomePage> {
  var _cyberdeck = 'No deck selected';
  var _cyberjack = 'No jack selected';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home page',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(_cyberdeck),
            Text(_cyberjack),
            RaisedButton(
              child: Text('Cyberdeck'),
              onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewDeckSelection()));
                setState(() {
                  if (result != null) {
                    _cyberdeck = result;
                  }
                });
              },
            ),
            RaisedButton(
              child: Text('Cyberjack'),
              onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewJackSelection()));
                setState(() {
                  if (result != null) {
                    _cyberjack = result;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

ListTile _makeSelectionTile(
        BuildContext context, String title, String subtitle) =>
    ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.pop(context, title + ':' + subtitle);
      },
    );

class ViewDeckSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select cyberdeck')),
      body: ListView(children: <Widget>[
        _makeSelectionTile(context, 'Erika MCD-6', 'A/S 4/3, 2 slots'),
        _makeSelectionTile(context, 'Spinrad Falcon', 'A/S 5/4, 4 slots'),
        _makeSelectionTile(context, 'MCT 360', 'A/S 6/5 6 slots'),
        _makeSelectionTile(context, 'Reraku Kitsune', 'A/S 7/6, 8 slots'),
        _makeSelectionTile(context, 'Shiawase Cyber-6', 'A/S 8/7, 10 slots'),
        _makeSelectionTile(context, 'Fairlight Excalibur', 'A/S 9/8, 12 slots'),
      ]),
    );
  }
}

class ViewJackSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select cyberjack')),
      body: ListView(children: <Widget>[
        _makeSelectionTile(context, 'Rating 1', 'D/F 4/3, +1 init'),
        _makeSelectionTile(context, 'Rating 2', 'D/F 5/4, +1 init'),
        _makeSelectionTile(context, 'Rating 3', 'D/F 6/5, +1 init'),
        _makeSelectionTile(context, 'Rating 4', 'D/F 7/6, +2 init'),
        _makeSelectionTile(context, 'Rating 5', 'D/F 8/7, +2 init'),
        _makeSelectionTile(context, 'Rating 6', 'D/F 9/8, +2 init'),
      ]),
    );
  }
}
