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
  DataProcessing,
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

final List<String> allActions = [
  'Backdoor Entry (illegal | major | outsider)',
  'Brute Force (illegal | major | any)',
  'Change Icon (legal | minor | user/admin)',
  'Check OS (illegal | major | admin)',
  'Control Device (legal | major | user/admin)',
  'Crack File (illegal | major | user/admin)',
  'Crash Program (illegal | major | admin)',
  'Data spike (illegal | major | any)',
  'Disarm data bomb (legal | major | user/admin)',
  'Edit file (legal | major | user/admin)',
  'Encrypt File (legal | major | user/admin)',
  'Enter/exit Host (legal | minor | depends)',
  'Erase Matrix Signature (illegal | major | user/admin)',
  'Format device (legal | major | admin)',
  'Full Matrix Defense (legal | major | any)',
  'Hash Check (illegal | major | user/admin)',
  'Hide (illegal | major | any)',
  'Jack Out (legal | major | any)',
  'Jam Signals (illegal | major | admin)',
  'Jump Into Rigged Device (legal | major | user/admin)',
  'Matrix Perception (legal | minor | any)',
  'Matrix Search (legal | extended 10 min | any)',
  'Probe (illegal | extended 1 min | any)',
  'Reboot device (legal | major | admin)',
  'Reconfigure Matrix Attribute (legal | minor | admin)',
  'Send Message (legal | minor | any)',
  'Set Data Bomb (illegal | major | admin)',
  'Snoop (illegal | major | admin)',
  'Spoof command (illegal | major | any)',
  'Switch Interface Mode (legal | minor | admin)',
  'Tarpit (illegal | major | any)',
  'Trace Icon (illegal | major | admin)',
];

String getActionDescription(String action) {
  // TODO
  return 'Nothing here yet.';
}
