import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:cyberdeck_helper/views/about.dart';
import 'package:cyberdeck_helper/views/condition_monitor.dart';
import 'package:cyberdeck_helper/views/validations.dart';
import 'package:cyberdeck_helper/views/action_info.dart';
import 'package:cyberdeck_helper/views/noise_info.dart';
import 'package:cyberdeck_helper/views/program_config.dart';
import 'package:cyberdeck_helper/views/char_deck_config.dart';
import 'package:cyberdeck_helper/rules.dart';

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
  About,
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

  Widget _buildAttribColumn(String name, String value) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              value,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final asdf = getValidASDFSorted(deckConfig);
    final errors = validateConfig(deckConfig);
    var appBarChildren = [
      IconButton(
        icon: Icon(Icons.favorite_border),
        tooltip: 'Condition Monitor',
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewConditionMonitor(
                config: deckConfig,
              ),
            ),
          );
          saveConfig();
        },
      ),
      PopupMenuButton<_AppBarDropdownOptions>(
        icon: Icon(Icons.settings),
        onSelected: (choice) async {
          if (choice == null) {
            return;
          }
          if (choice == _AppBarDropdownOptions.CharacterGear) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewCharGearConfig(
                  config: deckConfig,
                ),
              ),
            );
            saveConfig();
          } else if (choice == _AppBarDropdownOptions.Programs) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewProgramConfig(
                  config: deckConfig,
                ),
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
          } else if (choice == _AppBarDropdownOptions.About) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewAbout(),
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
            PopupMenuDivider(),
            PopupMenuItem(
              value: _AppBarDropdownOptions.About,
              child: Text('About'),
            ),
          ];
        },
      ),
    ];
    if (errors.length > 0) {
      appBarChildren.insert(
          0,
          IconButton(
            icon: Icon(Icons.error_outline),
            color: Colors.red,
            tooltip: 'Errors',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewValidations(
                    config: deckConfig,
                  ),
                ),
              );
            },
          ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        backgroundColor: Colors.green,
        actions: appBarChildren,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildAttribColumn(
                    'Cyberdeck',
                    deckConfig.deck ?? 'not selected',
                  ),
                  _buildAttribColumn(
                    'Cyberjack',
                    deckConfig.jack ?? 'not selected',
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildAttribColumn(
                  'Logic',
                  deckConfig.logic.toString(),
                ),
                _buildAttribColumn(
                  'Willpower',
                  deckConfig.willpower.toString(),
                ),
                _buildAttribColumn(
                  'Electr.',
                  deckConfig.electronics.toString(),
                ),
                _buildAttribColumn(
                  'Cracking',
                  deckConfig.cracking.toString(),
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
