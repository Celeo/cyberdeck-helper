import 'package:flutter/material.dart';
import 'package:cyberdeck_helper/rules.dart';

/// Enum for the two types of contributing gear.
enum _DeckOrJack {
  Deck,
  Jack,
}

class _CharGearViewConfiguration extends State<CharGearViewConfiguration> {
  static const _dropdownDefaultDeck = '- Select a deck -';
  static const _dropdownDefaultJack = '- Select a jack -';

  CharacterConfig character;

  _CharGearViewConfiguration({@required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character & Gear'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(50),
          children: <Widget>[
            _buildDropDown(
                character, _dropdownDefaultDeck, _DeckOrJack.Deck, <String>[
              'Rating 1: A/S 4/3, 2 slots',
              'Rating 2: A/S 5/4, 4 slots',
              'Rating 3: A/S 6/5 6 slots',
              'Rating 4: A/S 7/6, 8 slots',
              'Rating 5: A/S 8/7, 10 slots',
              'Rating 6: A/S 9/8, 12 slots',
            ]),
            _buildDropDown(
                character, _dropdownDefaultJack, _DeckOrJack.Jack, <String>[
              'Rating 1: D/F 4/3, +1 init',
              'Rating 2: D/F 5/4, +1 init',
              'Rating 3: D/F 6/5, +1 init',
              'Rating 4: D/F 7/6, +2 init',
              'Rating 5: D/F 8/7, +2 init',
              'Rating 6: D/F 9/8, +2 init',
            ]),
            TextField(
              decoration: InputDecoration(labelText: 'Enter Logic'),
              controller: TextEditingController(
                text: character.logic.toString(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (String val) {
                if (val != null) {
                  setState(() {
                    character.logic = int.parse(val);
                  });
                }
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Enter Willpower'),
              controller: TextEditingController(
                text: character.willpower.toString(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (String val) {
                if (val != null) {
                  setState(() {
                    character.willpower = int.parse(val);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Builds and returns a widget for selecting gear and setting the
  /// value in the app's memory.
  Widget _buildDropDown(CharacterConfig character, String defaultSelection,
      _DeckOrJack key, List<String> options) {
    var val;
    if (key == _DeckOrJack.Deck) {
      val = character.deck == null ? defaultSelection : character.deck;
    } else {
      val = character.jack == null ? defaultSelection : character.jack;
    }
    final allOptions = List.from(options)..insert(0, defaultSelection);
    return DropdownButton<String>(
      value: val,
      onChanged: (val) {
        if (val != defaultSelection) {
          setState(() {
            if (key == _DeckOrJack.Deck) {
              character.deck = val;
            } else {
              character.jack = val;
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

class CharGearViewConfiguration extends StatefulWidget {
  final CharacterConfig character;

  CharGearViewConfiguration({Key key, @required this.character})
      : super(key: key);

  @override
  _CharGearViewConfiguration createState() =>
      _CharGearViewConfiguration(character: this.character);
}
