import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cyberdeck_helper/program_config.dart';
import 'package:cyberdeck_helper/rules.dart';
import 'package:cyberdeck_helper/char_deck_config.dart';

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

enum _AppBarDropdownOptions {
  CharacterGear,
  Programs,
}

class HomePageState extends State<HomePage> {
  var character = CharacterConfig.starting();
  var situation = SituationConfig.starting();

  @override
  void initState() {
    super.initState();
    _afterInitState();
  }

  void _afterInitState() async {
    final prefs = await SharedPreferences.getInstance();
    var config = CharacterConfig.starting();
    config.logic = prefs.getInt('logic') ?? 1;
    config.willpower = prefs.getInt('willpower') ?? 1;
    config.deck = prefs.getString('deck');
    config.jack = prefs.getString('jack');
    setState(() {
      character = config;
    });
  }

  void saveConfig() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('logic', character.logic);
    prefs.setInt('willpower', character.willpower);
    prefs.setString('deck', character.deck);
    prefs.setString('jack', character.jack);
  }

  @override
  Widget build(BuildContext context) {
    final asdf = validASDF();
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        actions: <Widget>[
          PopupMenuButton<_AppBarDropdownOptions>(
            onSelected: (choice) async {
              if (choice == null) {
                return;
              }
              if (choice == _AppBarDropdownOptions.CharacterGear) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CharGearViewConfiguration(character: character),
                  ),
                );
                saveConfig();
              } else if (choice == _AppBarDropdownOptions.Programs) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProgramViewConfiguration(situation: situation),
                  ),
                );
                saveConfig();
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: _AppBarDropdownOptions.CharacterGear,
                  child: Text('Character/Gear'),
                ),
                PopupMenuItem(
                  value: _AppBarDropdownOptions.Programs,
                  child: Text('Programs'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Cyberdeck',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(character.deck ?? 'not selected'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Cyberjack',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(character.jack ?? 'not selected'),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Logic',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(character.logic.toString()),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Willpower',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(character.willpower.toString()),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildASDFSelector(ASDF.Attack, asdf),
                _buildASDFSelector(ASDF.Sleaze, asdf),
                _buildASDFSelector(ASDF.DataProcessing, asdf),
                _buildASDFSelector(ASDF.Firewall, asdf),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildASDFSelector(ASDF attribute, List<int> values) {
    var currentValue;
    switch (attribute) {
      case ASDF.Attack:
        currentValue = situation.attack;
        break;
      case ASDF.Sleaze:
        currentValue = situation.sleaze;
        break;
      case ASDF.DataProcessing:
        currentValue = situation.dataProcessing;
        break;
      case ASDF.Firewall:
        currentValue = situation.firewall;
        break;
    }
    return Column(
      children: <Widget>[
        Text(attribute.toString().split('.')[1],
            style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<int>(
          value: values.contains(currentValue) ? currentValue : 0,
          onChanged: (val) {
            if (val != null) {
              setState(() {
                switch (attribute) {
                  case ASDF.Attack:
                    situation.attack = val;
                    break;
                  case ASDF.Sleaze:
                    situation.sleaze = val;
                    break;
                  case ASDF.DataProcessing:
                    situation.dataProcessing = val;
                    break;
                  case ASDF.Firewall:
                    situation.firewall = val;
                    break;
                }
              });
            }
          },
          items: values
              .map((e) =>
                  DropdownMenuItem<int>(value: e, child: Text(e.toString())))
              .toList(),
        ),
      ],
    );
  }

  List<int> validASDF() {
    Set<int> values = Set.from([0]);
    if (character.deck != null) {
      final parts = character.deck
          .split(': ')[1]
          .split(' ')[1]
          .replaceFirst(',', '')
          .split('/');
      values.add(int.parse(parts[0]));
      values.add(int.parse(parts[1]));
    }
    if (character.jack != null) {
      final parts = character.jack
          .split(': ')[1]
          .split(' ')[1]
          .replaceFirst(',', '')
          .split('/');
      values.add(int.parse(parts[0]));
      values.add(int.parse(parts[1]));
    }
    return List.from(values)..sort();
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}
