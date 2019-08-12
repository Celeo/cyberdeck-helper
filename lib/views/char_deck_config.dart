import 'package:flutter/material.dart';
import 'package:cyberdeck_helper/rules.dart';

/// Enum for the two types of contributing gear.
enum _DeckOrJack {
  Deck,
  Jack,
}

/// Enum for the enterable fields on this view.
enum _Attribs {
  Logic,
  Willpower,
  Electronics,
  Cracking,
}

class _ViewCharGearConfigState extends State<ViewCharGearConfig> {
  static const _dropdownDefaultDeck = '- Select a deck -';
  static const _dropdownDefaultJack = '- Select a jack -';

  DeckConfig config;
  final controllerLogic = TextEditingController();
  final controllerWillpower = TextEditingController();
  final controllerElectronics = TextEditingController();
  final controllerCracking = TextEditingController();

  _ViewCharGearConfigState({@required this.config});

  @override
  void initState() {
    super.initState();
    [
      [controllerLogic, _Attribs.Logic],
      [controllerWillpower, _Attribs.Willpower],
      [controllerElectronics, _Attribs.Electronics],
      [controllerCracking, _Attribs.Cracking],
    ].forEach((pair) {
      final controller = pair[0] as TextEditingController;
      final attrib = pair[1] as _Attribs;
      controller.addListener(() {
        if (controller.text != null && controller.text.isNotEmpty) {
          setState(() {
            switch (attrib) {
              case _Attribs.Logic:
                config.logic = int.parse(controller.text);
                break;
              case _Attribs.Willpower:
                config.willpower = int.parse(controller.text);
                break;
              case _Attribs.Electronics:
                config.electronics = int.parse(controller.text);
                break;
              case _Attribs.Cracking:
                config.cracking = int.parse(controller.text);
                break;
            }
          });
        }
      });
      var text;
      switch (attrib) {
        case _Attribs.Logic:
          text = config.logic.toString();
          break;
        case _Attribs.Willpower:
          text = config.willpower.toString();
          break;
        case _Attribs.Electronics:
          text = config.electronics.toString();
          break;
        case _Attribs.Cracking:
          text = config.cracking.toString();
          break;
      }
      controller.text = text;
    });
  }

  @override
  void dispose() {
    controllerLogic.dispose();
    controllerWillpower.dispose();
    controllerElectronics.dispose();
    controllerCracking.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // controllerLogic.text = config.logic.toString();
    // controllerWillpower.text = config.willpower.toString();
    // controllerElectronics.text = config.electronics.toString();
    // controllerCracking.text = config.cracking.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Character & Gear'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(left: 50.0, right: 50.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
              child: Text(
                'Configure Character',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            _buildDropDown(
              config,
              _dropdownDefaultDeck,
              _DeckOrJack.Deck,
              cyberdecks,
            ),
            _buildDropDown(
              config,
              _dropdownDefaultJack,
              _DeckOrJack.Jack,
              cyberjacks,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Logic'),
              controller: controllerLogic,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Willpower'),
              controller: controllerWillpower,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Electronics'),
              controller: controllerElectronics,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Cracking'),
              controller: controllerCracking,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds and returns a widget for selecting gear and setting the
  /// value in the app's memory.
  Widget _buildDropDown(DeckConfig config, String defaultSelection,
      _DeckOrJack key, List<String> options) {
    var val;
    if (key == _DeckOrJack.Deck) {
      val = config.deck == null ? defaultSelection : config.deck;
    } else {
      val = config.jack == null ? defaultSelection : config.jack;
    }
    final allOptions = List.from(options)..insert(0, defaultSelection);
    return DropdownButton<String>(
      value: val,
      onChanged: (val) {
        if (val != defaultSelection) {
          setState(() {
            if (key == _DeckOrJack.Deck) {
              config.deck = val;
            } else {
              config.jack = val;
            }
          });
        }
      },
      items: allOptions
          .map<DropdownMenuItem<String>>(
            (value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
    );
  }
}

class ViewCharGearConfig extends StatefulWidget {
  final DeckConfig config;

  ViewCharGearConfig({Key key, @required this.config}) : super(key: key);

  @override
  _ViewCharGearConfigState createState() =>
      _ViewCharGearConfigState(config: this.config);
}
