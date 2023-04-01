import 'package:flutter/material.dart';

class Job {
  static const tanker = '탱커';
  static const warrior = '워리어';
  static const shooter = '슈터';
  static const mage = '메이지';
  static const priest = '프리스트';
  static const ranger = '레인저';
}

Map<String, Image> jobIcon = {
  '탱커': Image.asset(
    'assets/images/icons/tanker.png',
    height: 20,
    width: 20,
    color: const Color(0xFF001E30),
  ),
  '워리어': Image.asset(
    'assets/images/icons/warrior.png',
    height: 20,
    width: 20,
    color: const Color(0xFF001E30),
  ),
  '슈터': Image.asset(
    'assets/images/icons/shooter.png',
    height: 20,
    width: 20,
    color: const Color(0xFF001E30),
  ),
  '메이지': Image.asset(
    'assets/images/icons/mage.png',
    height: 20,
    width: 20,
    color: const Color(0xFF001E30),
  ),
  '프리스트': Image.asset(
    'assets/images/icons/priest.png',
    height: 20,
    width: 20,
    color: const Color(0xFF001E30),
  ),
  '레인저': Image.asset(
    'assets/images/icons/ranger.png',
    height: 20,
    width: 20,
    color: const Color(0xFF001E30),
  ),
};

class Rank {
  static const ssr = 'SSR';
  static const sr = 'SR';
  static const r = 'R';
  static const n = 'N';
}

class CharacterElement {
  static const fire = '불';
  static const water = '물';
  static const thunder = '번개';
  static const light = '빛';
  static const darkness = '어둠';
}

class WeaponType {
  static const gauntlet = '건틀렛';
  static const swordAndKite = '검&방패';
  static const twoHandedSword = '대검';
  static const magicalDevice = '마법 기구';
  static const wand = '마법 지팡이';
  static const dagger = '비수';
  static const relic = '성물';
  static const swordBow = '소드 보우';
  static const scepter = '왕홀';
  static const longSpear = '장창';
  static const battleAx = '전투 도끼';
  static const spearAndKite = '창&방패';
  static const oneHandedSword = '한손검';
  static const bow = '활';
}

const weaponTypeList = [
  WeaponType.gauntlet,
  WeaponType.swordAndKite,
  WeaponType.twoHandedSword,
  WeaponType.magicalDevice,
  WeaponType.wand,
  WeaponType.dagger,
  WeaponType.relic,
  WeaponType.swordBow,
  WeaponType.scepter,
  WeaponType.longSpear,
  WeaponType.battleAx,
  WeaponType.spearAndKite,
  WeaponType.oneHandedSword,
  WeaponType.bow,
];

final rankList = [
  Rank.ssr,
  Rank.sr,
  Rank.r,
  Rank.n,
];
final jobList = [
  Job.tanker,
  Job.warrior,
  Job.shooter,
  Job.mage,
  Job.priest,
  Job.ranger,
];
final elementList = [
  CharacterElement.fire,
  CharacterElement.water,
  CharacterElement.thunder,
  CharacterElement.light,
  CharacterElement.darkness,
];

class RangePrefix {
  static const String none = '-';
  static const String self = '자신';
  static const String nthBlock = 'n칸';
  static const String cross = '십자 n칸';
}

class RadiusPrefix {
  static const String none = '-';
  static const String single = '단일';
  static const String line = '직선 n칸';
  static const String threeByFour = '직선 4X3칸';
  static const String round = '주변 n바퀴';
  static const String diamond = '마름모 n칸';
  static const String entire = '모든 전장';
}

class CoolTime {
  static const String zero = '-';
  static const String one = '1턴';
  static const String two = '2턴';
  static const String three = '3턴';
  static const String four = '4턴';
}

class Type {
  static const String pAtk = "물리 피해";
  static const String mAtk = "마법 피해";
  static const String passive = "패시브";
  static const String active = "액티브";
  static const String support = "지원";
  static const String heal = "치유";
}
