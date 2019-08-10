enum MatrixMode {
  AR,
  Cold,
  Hot,
}

class DeckConfig {
  int logic;
  int willpower;
  int cracking;
  int electronics;

  String deck;
  String jack;

  int attack;
  int sleaze;
  int dataProcessing;
  int firewall;
  int noise;
  MatrixMode mode;
  List<String> runningPrograms;

  DeckConfig(
    this.logic,
    this.willpower,
    this.cracking,
    this.electronics,
    this.deck,
    this.jack,
    this.attack,
    this.sleaze,
    this.dataProcessing,
    this.firewall,
    this.noise,
    this.mode,
    this.runningPrograms,
  );

  DeckConfig.start() {
    logic = 0;
    willpower = 0;
    cracking = 0;
    electronics = 0;
    deck = null;
    jack = null;
    attack = 0;
    sleaze = 0;
    dataProcessing = 0;
    firewall = 0;
    noise = 0;
    mode = MatrixMode.AR;
    runningPrograms = [];
  }

  DeckConfig.fromJson(Map<String, dynamic> json)
      : logic = json['logic'],
        willpower = json['willpower'],
        cracking = json['cracking'],
        electronics = json['electronics'],
        deck = json['deck'],
        jack = json['jack'],
        attack = json['attack'],
        sleaze = json['sleaze'],
        dataProcessing = json['dataProcessing'],
        firewall = json['firewall'],
        noise = 0,
        mode = MatrixMode.AR,
        runningPrograms = json['runningPrograms'].cast<String>();

  Map<String, dynamic> toJson() => {
        'logic': logic,
        'willpower': willpower,
        'cracking': cracking,
        'electronics': electronics,
        'deck': deck,
        'jack': jack,
        'attack': attack,
        'sleaze': sleaze,
        'dataProcessing': dataProcessing,
        'firewall': firewall,
        'runningPrograms': runningPrograms
      };
}

enum ASDF {
  Attack,
  Sleaze,
  DataProc,
  Firewall,
}

// TODO program subtitles
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
    'Cracking + Logic vs Willpower + Firewall',
    "Attempt to use a previously-created backdoor on a host, device, or other area. Net hits from the Probe action used to place the backdoor are a dice bonus for this test. If successful, this test grants Admin access to the target which does not increase OS due to time. If this test fails, the backdoor is deleted. Failing this test does not alert the owner of the target."
  ],
  [
    'Brute Force (illegal | major | any)',
    'Cracking + Logic vs Willpower + Firewall',
    "Attack a device. Always alerts the owner if the attempted hack. This test can be attempted again if failed. If attempting to gain admin access without first gaining user access, the defense roll is made at +2 and the target's Defense Rating is +4."
  ],
  [
    'Change Icon (legal | minor | user/admin)',
    '',
    "Change the target's icon to something else."
  ],
  [
    'Check OS (illegal | major | admin)',
    'Cracking + Logic (4)',
    "Learn your current OS."
  ],
  [
    'Control Device (legal | major | user/admin)',
    'Electronics + Logic vs Willpower + Firewall',
    "Control the device as if you were the owner performing a standard test, maintaining control until you relinquish it or are forced out. Roll the above test if the action doesn't otherwise have a test. Cannot take control of a device that's being controlled by a rigger. Performing actions requires the same level of access normally required for that action.\n\nIf performing an action on the device requires a specific test, then perform that roll using listed attributes if you're in AR, and using the corresponding mental attribute if hacking in VR: Body = Willpower, Agility = Logic, REaction = Intuition, and Strength = Charisma."
  ],
  [
    'Crack File (illegal | major | user/admin)',
    'Cracking + Logic vs Encryption rating * 2',
    "Remove file protection."
  ],
  [
    'Crash Program (illegal | major | admin)',
    'Cracking + Logic vs Data Processing + Device Rating',
    "Crash target program on target device or persona. If successful, that program cannot be used until the target device is rebooted."
  ],
  [
    'Data spike (illegal | major | any)',
    'Cracking + Logic vs Data Processing + Firewall',
    "Deal damage equal to {Attack Rating / 2, round up, + net hits} to target."
  ],
  [
    'Disarm data bomb (legal | major | user/admin)',
    'Cracking + Logic vs data bomb rating * 2',
    "If you get any net hits, the bomb is deleted, otherwise it explodes which causes damage and may delete the file it's on."
  ],
  [
    'Edit file (legal | major | user/admin)',
    'Electronics + Logic vs Intuition/Sleaze + Firewall',
    "Fails if the file is protected.\n\nCreate/change/copy/delete a file. The defender is the owner or the host (if in a host). Each action alters 1 detail of the file. If you want to continuously perform an edit, you must perform the action once per turn. If the file has a data bomb on it, the bomb explodes."
  ],
  [
    'Encrypt File (legal | major | user/admin)',
    'Electronics + Logic',
    "Encrypt file to discourage attempts to read it. The encryption rating is equal to the test's hits."
  ],
  [
    'Enter/exit Host (legal | minor | depends)',
    '',
    "Level of access granted when entering a host depends on the host's settings."
  ],
  [
    'Erase Matrix Signature (illegal | major | user/admin)',
    'Electronics + Logic vs Willpower/Firewall + Firewall',
    "Remove a Resonance signature. Requires a Resonance rating."
  ],
  [
    'Format device (legal | major | admin)',
    'Electronics + Logic vs Willpower/Firewall + Firewall',
    "Rewrite boot code so the next time the device shuts off, it won't boot. This status does not prevent mechanical devices from functioning so long as they can do so without the Matrix. Requires fixing the device before it can boot again, using the same rules as repairing a bricked device, with required hits equal to the device's rating."
  ],
  [
    'Full Matrix Defense (legal | major | any)',
    '',
    "Forgoing attacking, add your Firewall rating to the next defense roll."
  ],
  [
    'Hash Check (illegal | major | user/admin)',
    ' Electronics + Logic',
    "Search the Matrix for an encrypted file without having to decrypt every file. If someone tells you the hash, the test threshold is 1; otherwise it's 4. Meeting the threshold means the number of possible matching files is 32, and for every net hit that total is halved. Optionally, the hacker can perform this action multiple times with a -2 penalty to continue to halve the pool of files with successes and net hits."
  ],
  [
    'Hide (illegal | major | any)',
    'Cracking + Intuition vs Intuition/Sleaze + Data Processing',
    "Force an icon to lose track of you. You cannot hide from an icon that has user or admin access to anything in your PAN."
  ],
  [
    'Jack Out (legal | major | any)',
    'Electronics + Willpower vs Attack/Charisma + Data Processing',
    "Immediately get out of the Matrix. Dumpshock applies if in VR. Only requires a test if link-locked. If link-locked by multiple personas, your hits on this test must by compared to each of those personas to determine if you are successful. This action cannot be performed on other personas."
  ],
  [
    'Jam Signals (illegal | major | admin)',
    'Cracking + Logic',
    "Turn the device into a jammer. Ends when the device is used for anything else. Hits on the test are added to the noise level within 100m."
  ],
  [
    'Jump Into Rigged Device (legal | major | user/admin)',
    'Electronics + Logic vs Willpower/Firewall + Firewall',
    "Jump into a device that ha sa rigger adaption. You must be in VR and be using a control rig. No test is required if you are the device's owner or have permission from the owner. Fails if someone is already jumped into that device."
  ],
  [
    'Matrix Perception (legal | minor | any)',
    'Electronics + Intuition (vs Sleaze + Willpower)',
    "Gives information about a target. 0 net hits reveals the icon. 1 net hit reveals device rating and what the device or icon calls itself. 2 net hits reveals attribute ratings and running programs. Additional hits grant information from the GM. No test is required to spot icons that are not running silent. Spotting a Technomancer requires 5 hits."
  ],
  [
    'Matrix Search (legal | extended 10 min | any)',
    'Electronics + Intuition',
    "Search for publicly accessible information. The number of hits can be compared to the \textbf{Logwork Results} table."
  ], // TODO info on the table
  [
    'Probe (illegal | extended 1 min | any)',
    'Cracking + Logic vs Willpower/Firewall + Firewall',
    "Attempt to create a backdoor in the target. Does not raise an alarm unless you roll a critical glitch. If  successful, a backdoor is created that lasts {10 - host/device rating} in hours. Net hits on this test are added to the future Backdoor Entry test."
  ],
  [
    'Reboot device (legal | major | admin)',
    'Electronics + Logic vs Willpower/Firewall + Firewall',
    "Target device shuts down and comes back online at the end of the next combat round.\n\nNo test is required if you are the owner."
  ],
  [
    'Reconfigure Matrix Attribute (legal | minor | admin)',
    '',
    "Swap the base ratings of two Matrix attributes in your persona."
  ],
  [
    'Send Message (legal | minor | any)',
    '',
    "Send text, images, or audio to the target via their commcode. If using DNI, the amount of information sent can be more complicated. Can be used to open a live feed from any recording devices to any recipients."
  ],
  [
    'Set Data Bomb (illegal | major | admin)',
    'Electronics + Logic vs Device Rating * 2',
    "Set a data bomb on a file. Select the desired rating, up to the net hits on the test, whether or not the bomb will destroy the file it's on if it explodes, and the passcode to disarm the bomb temporarily. A file can only have a single bomb on it.\n\nWhen a bomb explodes, it causes \texttt{rating * 4} Matrix damage that's resisted with Willpower and may destroy the file it's on if configured to do so. A detonated bomb is deleted from the file."
  ],
  [
    'Snoop (illegal | major | admin)',
    'Cracking + Logic vs Logic/Data Processing + Firewall',
    "Intercept Matrix traffic to and from the device while you have access. You can view the data live or save it for later."
  ],
  [
    'Spoof command (illegal | major | any)',
    'Cracking + Logic vs Data Processing/Pilot + Firewall',
    "Send a device a command that it interprets as coming from its owner. The device attempts to perform the action as its next Major action."
  ],
  [
    'Switch Interface Mode (legal | minor | admin)',
    '',
    "Switch from AR to VR or vice versa."
  ],
  [
    'Tarpit (illegal | major | any)',
    'Cracking + Logic vs Data Processing + Firewall',
    "Deal {1 + net hits} Matrix damage to the target and reduce their Data Processing rating by that amount. The cannot perform any Matrix actions while its Data Processing rating is 0. The rating recovers at 1 per combat round."
  ],
  [
    'Trace Icon (illegal | major | admin)',
    'Electronics + Intuition vs Willpower + Sleaze',
    "Trace an icon to its physical location, and know its location for as long as you can detect the target. Does not work on IC or hosts, but does work on offline hosts with physical hardware."
  ],
];

String getActionDescription(String action) {
  return allActions.firstWhere((e) => e[0] == action)[2];
}
