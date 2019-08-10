enum MatrixMode {
  AR,
  Cold,
  Hot,
}

class CharacterConfig {
  int logic, willpower;
  String deck;
  String jack;

  CharacterConfig(int logic, int willpower, String deck, String jack);

  CharacterConfig.starting() {
    logic = 1;
    willpower = 1;
    deck = null;
    jack = null;
  }
}

class SituationConfig {
  int attack;
  int sleaze;
  int dataProcessing;
  int firewall;
  int noise;
  MatrixMode mode;
  List<String> runningPrograms;

  SituationConfig(int attack, int sleaze, int dataProcessing, int firewall,
      int noise, MatrixMode mode, List<String> runningPrograms);

  SituationConfig.starting() {
    attack = 0;
    sleaze = 0;
    dataProcessing = 0;
    firewall = 0;
    noise = 0;
    mode = MatrixMode.AR;
    runningPrograms = [];
  }

  void loadASDF(List<String> values) {
    final converted = values.map((e) => int.parse(e)).toList();
    attack = converted[0];
    sleaze = converted[1];
    dataProcessing = converted[2];
    firewall = converted[3];
  }
}

enum ASDF {
  Attack,
  Sleaze,
  DataProc,
  Firewall,
}

final List<String> allPrograms = [
  'Baby Monitor',
  'Browse',
  'Configurator',
  'Edit',
  'Encryption',
  'Signal',
  'Toolbox',
  'Virtual Machine',
  'Armor',
  'Biofeedback',
  'Biofeedback Filter',
  'Blackout',
  'Decryption',
  'Defuse',
  'Exploit',
  'Fork',
  'Lockdown',
  'Overclock',
  'Stealth',
  'Trace',
];

final List<List<String>> allActions = [
  [
    'Backdoor Entry (illegal | major | outsider)',
    'Cracking + Logic vs Willpower + Firewall'
  ],
  [
    'Brute Force (illegal | major | any)',
    'Cracking + Logic vs Willpower + Firewall'
  ],
  ['Change Icon (legal | minor | user/admin)', ''],
  ['Check OS (illegal | major | admin)', 'Cracking + Logic (4)'],
  [
    'Control Device (legal | major | user/admin)',
    'Electronics + Logic vs Willpower + Firewall'
  ],
  [
    'Crack File (illegal | major | user/admin)',
    'Cracking + Logic vs Encryption rating * 2'
  ],
  [
    'Crash Program (illegal | major | admin)',
    'Cracking + Logic vs Data Processing + Device Rating'
  ],
  [
    'Data spike (illegal | major | any)',
    'Cracking + Logic vs Data Processing + Firewall'
  ],
  [
    'Disarm data bomb (legal | major | user/admin)',
    'Cracking + Logic vs data bomb rating * 2'
  ],
  [
    'Edit file (legal | major | user/admin)',
    'Electronics + Logic vs Intuition/Sleaze + Firewall'
  ],
  ['Encrypt File (legal | major | user/admin)', 'Electronics + Logic'],
  ['Enter/exit Host (legal | minor | depends)', ''],
  [
    'Erase Matrix Signature (illegal | major | user/admin)',
    'Electronics + Logic vs Willpower/Firewall + Firewall'
  ],
  [
    'Format device (legal | major | admin)',
    'Electronics + Logic vs Willpower/Firewall + Firewall'
  ],
  ['Full Matrix Defense (legal | major | any)', ''],
  ['Hash Check (illegal | major | user/admin)', ' Electronics + Logic'],
  [
    'Hide (illegal | major | any)',
    'Cracking + Intuition vs Intuition/Sleaze + Data Processing'
  ],
  [
    'Jack Out (legal | major | any)',
    'Electronics + Willpower vs Attack/Charisma + Data Processing'
  ],
  ['Jam Signals (illegal | major | admin)', 'Cracking + Logic'],
  [
    'Jump Into Rigged Device (legal | major | user/admin)',
    'Electronics + Logic vs Willpower/Firewall + Firewall'
  ],
  [
    'Matrix Perception (legal | minor | any)',
    'Electronics + Intuition (vs Sleaze + Willpower)'
  ],
  ['Matrix Search (legal | extended 10 min | any)', 'Electronics + Intuition'],
  [
    'Probe (illegal | extended 1 min | any)',
    'Cracking + Logic vs Willpower/Firewall + Firewall'
  ],
  [
    'Reboot device (legal | major | admin)',
    'Electronics + Logic vs Willpower/Firewall + Firewall'
  ],
  ['Reconfigure Matrix Attribute (legal | minor | admin)', ''],
  ['Send Message (legal | minor | any)', ''],
  [
    'Set Data Bomb (illegal | major | admin)',
    'Electronics + Logic vs Device Rating * 2'
  ],
  [
    'Snoop (illegal | major | admin)',
    'Cracking + Logic vs Logic/Data Processing + Firewall'
  ],
  [
    'Spoof command (illegal | major | any)',
    'Cracking + Logic vs Data Processing/Pilot + Firewall'
  ],
  ['Switch Interface Mode (legal | minor | admin)', ''],
  [
    'Tarpit (illegal | major | any)',
    'Cracking + Logic vs Data Processing + Firewall'
  ],
  [
    'Trace Icon (illegal | major | admin)',
    'Electronics + Intuition vs Willpower + Sleaze'
  ],
];

String getActionDescription(String action) {
  // TODO
  return 'Nothing here yet.';
}
