enum MatrixMode {
  AR,
  Cold,
  Hot,
}

class CharacterConfig {
  int logic, willpower;
  String deck;
  String jack;

  CharacterConfig(int logic, int willpower);

  CharacterConfig.starting() {
    logic = 1;
    willpower = 1;
    deck = null;
    jack = null;
  }
}

class SituationConfig {
  int noise;
  MatrixMode mode;
  List<String> runningPrograms;

  SituationConfig(int noise, MatrixMode mode, List<String> runningPrograms);

  SituationConfig.starting() {
    noise = 0;
    mode = MatrixMode.AR;
    runningPrograms = [];
  }
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
