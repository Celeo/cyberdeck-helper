import 'dart:convert';

import 'package:cyberdeck_helper/action_info.dart';
import 'package:cyberdeck_helper/noise_info.dart';
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
  NoiseInfo,
}

class HomePageState extends State<HomePage> {
  var deckConfig = DeckConfig.start();

  @override
  void initState() {
    super.initState();
    _afterInitState();
  }

  /// Function ran after the initial state is set up. This
  /// function attempts to load preferences from the device
  /// and populate the current state.
  void _afterInitState() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('config');
    if (json == null) {
      return;
    }
    final map = jsonDecode(json);
    final config = DeckConfig.fromJson(map);
    setState(() {
      deckConfig = config;
    });
  }

  /// Save the current configuration to the device.
  void saveConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(deckConfig);
    prefs.setString('config', json);
  }

  /// Returns a list of ints that are valid ASDF attributes
  /// for the current cyberdeck and cyberjack selection. In
  /// addition to the results from the gear, the value '0' is
  /// always returned.
  List<int> getValidASDF() {
    Set<int> values = Set.from([0]);
    if (deckConfig.deck != null) {
      final parts = deckConfig.deck
          .split(': ')[1]
          .split(' ')[1]
          .replaceFirst(',', '')
          .split('/');
      values.add(int.parse(parts[0]));
      values.add(int.parse(parts[1]));
    }
    if (deckConfig.jack != null) {
      final parts = deckConfig.jack
          .split(': ')[1]
          .split(' ')[1]
          .replaceFirst(',', '')
          .split('/');
      values.add(int.parse(parts[0]));
      values.add(int.parse(parts[1]));
    }
    return List.from(values)..sort();
  }

  /// Builds and returns the ASDF attribute selection row found
  /// on the main view of the app.
  Widget buildASDFDisplayRow(List<int> asdf) {
    final attackRating = deckConfig.attack + deckConfig.sleaze;
    final defenseRating = deckConfig.dataProcessing + deckConfig.firewall;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildASDFSelector(ASDF.Attack, asdf),
        _buildASDFSelector(ASDF.Sleaze, asdf),
        _buildASDFSelector(ASDF.DataProc, asdf),
        _buildASDFSelector(ASDF.Firewall, asdf),
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text('AR', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Text(attackRating.toString()),
          ],
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text('DR', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Text(defenseRating.toString()),
          ],
        ),
      ],
    );
  }

  /// Builds and returns a single ASDF selector column for the row.
  Widget _buildASDFSelector(ASDF attribute, List<int> values) {
    var currentValue;
    switch (attribute) {
      case ASDF.Attack:
        currentValue = deckConfig.attack;
        break;
      case ASDF.Sleaze:
        currentValue = deckConfig.sleaze;
        break;
      case ASDF.DataProc:
        currentValue = deckConfig.dataProcessing;
        break;
      case ASDF.Firewall:
        currentValue = deckConfig.firewall;
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
                    deckConfig.attack = val;
                    break;
                  case ASDF.Sleaze:
                    deckConfig.sleaze = val;
                    break;
                  case ASDF.DataProc:
                    deckConfig.dataProcessing = val;
                    break;
                  case ASDF.Firewall:
                    deckConfig.firewall = val;
                    break;
                }
              });
              saveConfig();
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

  @override
  Widget build(BuildContext context) {
    final asdf = getValidASDF();
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        backgroundColor: Colors.green,
        actions: <Widget>[
          // TODO errors like attribute selection, too many programs, etc.
          // TODO condition monitor
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
                        CharGearViewConfiguration(config: deckConfig),
                  ),
                );
                saveConfig();
              } else if (choice == _AppBarDropdownOptions.Programs) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProgramViewConfiguration(config: deckConfig),
                  ),
                );
                saveConfig();
              } else if (choice == _AppBarDropdownOptions.NoiseInfo) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewNoiseInfo(),
                  ),
                );
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
                PopupMenuDivider(),
                PopupMenuItem(
                  value: _AppBarDropdownOptions.NoiseInfo,
                  child: Text('Noise Info'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Cyberdeck',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          deckConfig.deck ?? 'not selected',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Cyberjack',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          deckConfig.jack ?? 'not selected',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Logic',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        deckConfig.logic.toString(),
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Willpower',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        deckConfig.willpower.toString(),
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            buildASDFDisplayRow(asdf),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Noise'),
                        controller: TextEditingController(
                            text: deckConfig.noise.toString() ?? '0'),
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              deckConfig.noise = int.parse(val);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Matrix mode',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<MatrixMode>(
                      value: deckConfig.mode ?? MatrixMode.AR,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            deckConfig.mode = val;
                          });
                        }
                      },
                      items: MatrixMode.values
                          .map((e) => DropdownMenuItem<MatrixMode>(
                                value: e,
                                child: Text(e.toString().split('.')[1]),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ],
            ),
            Divider(),
            Container(
              child: Text(
                'Actions',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allActions.length,
                itemBuilder: (context, i) => ListTile(
                  title: Text(allActions[i][0]),
                  subtitle: Text(allActions[i][1]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ViewActionInfo(actionName: allActions[i][0]),
                      ),
                    );
                  },
                ),
              ),
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
