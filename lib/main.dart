import 'package:flutter/material.dart';

enum Role {
  Unknown,
  Werewolf,
  WerewolfKing,
  Villager,
  Seer,
  Witch,
  Hunter,
  Savior,
  Idiot,
}
String roleName(Role role) {
  const roleNameTable = const <String>[
    '未知',
    '狼人',
    '狼王',
    '普通村民',
    '预言家',
    '女巫',
    '猎人',
    '守卫',
    '白痴',
  ];
  return roleNameTable[role.index];
}

class Player {
  Role role;
  int playerNumber;
  bool dead = false;
  final events = <Event>[];
  String get name => '$playerNumber 号玩家';

  Player(this.playerNumber, [this.role = Role.Unknown]);
  String ruleName() => roleName(role);
}

abstract class Stage {
  String get name;
  String get summary;
  Stage generateNext();
}

class NightStage extends Stage {
  int _day;
  String get name => "第 $_day 天黑夜";
  String get summary => '';
  NightStage(this._day);

  @override
  Stage generateNext() => new DayStage(_day + 1);
}

class FirstNightStage extends NightStage {
  FirstNightStage(): super(1);
  
  @override
  Stage generateNext() => new RunForTheSheriff();
}

class DayStage extends Stage {
  int _day;
  String get name => "第 $_day 天白天";
  String get summary => '';

  DayStage(this._day);

  @override
  Stage generateNext() => new NightStage(_day);
}

class RunForTheSheriff extends Stage {
  String get name => "竞选警长";
  String get summary => '';
  
  @override
  Stage generateNext() => new DayStage(2);
}

abstract class Event {
  String get message;
  Player player;
}

class Kill extends Event {
  Player target;
  String get message => '${player.name} 击杀了 ${target.name}';
}

class Game {
  final players = <Player>[];

  Game() {
    for (int i = 0; i < 12; i++) {
      players.add(new Player(i));
    }
  }
}

void main() {
  runApp(
    new Center(
      child: new Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}
