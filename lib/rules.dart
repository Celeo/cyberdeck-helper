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
}

enum ASDF {
  Attack,
  Sleaze,
  DataProcessing,
  Firewall,
}

final List<String> basicPrograms = [
  'Baby Monitor',
  'Browse',
  'Configurator',
  'Edit',
  'Encryption',
  'Signal',
  'Toolbox',
  'Virtual Machine',
];

final List<String> hackingPrograms = [
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

final List<String> allPrograms = new List.from(basicPrograms)
  ..addAll(hackingPrograms);
