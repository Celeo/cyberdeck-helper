import 'package:flutter/material.dart';

import 'package:cyberdeck_helper/rules.dart';

Widget buildASDFDisplayRow(void Function(void Function()) setState,
    SituationConfig config, List<int> asdf) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      _buildASDFSelector(ASDF.Attack, asdf, config, setState),
      _buildASDFSelector(ASDF.Sleaze, asdf, config, setState),
      _buildASDFSelector(ASDF.DataProcessing, asdf, config, setState),
      _buildASDFSelector(ASDF.Firewall, asdf, config, setState),
    ],
  );
}

Widget _buildASDFSelector(ASDF attribute, List<int> values,
    SituationConfig config, void Function(void Function()) setState) {
  var currentValue;
  switch (attribute) {
    case ASDF.Attack:
      currentValue = config.attack;
      break;
    case ASDF.Sleaze:
      currentValue = config.sleaze;
      break;
    case ASDF.DataProcessing:
      currentValue = config.dataProcessing;
      break;
    case ASDF.Firewall:
      currentValue = config.firewall;
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
                  config.attack = val;
                  break;
                case ASDF.Sleaze:
                  config.sleaze = val;
                  break;
                case ASDF.DataProcessing:
                  config.dataProcessing = val;
                  break;
                case ASDF.Firewall:
                  config.firewall = val;
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
