import 'package:flutter/material.dart';

const aboutText = '''
All references to Shadowrun game names or mechanics are property of Catalyst Game Labs.

The Topps Company, Inc., (2019) Shadowrun, Sixth World. Spokane, WA: Catalyst Game Labs, an imprint of InMediaRes Productions, LLC.

This app is not a substitute for purchasing the core rule book; you'll need to buy it in order to play the game.
''';

class ViewAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: Text(
          aboutText,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
