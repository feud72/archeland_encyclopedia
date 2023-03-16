import 'package:archeland_encyclopedia/src/features/runes/domain/rune.dart';
import 'package:archeland_encyclopedia/src/features/runes/domain/rune_type.dart';

class RuneRepository {
  static List<Rune> getRunes() {
    return [
      const Rune(
        name: '흡혈귀',
        type: '물리',
        twoPiecesEffect: '물리 공격력 +5%',
        fourPiecesEffect: '액티브 공격 시 [전투 후] HP  20% 회복',
      ),
      const Rune(
        name: '성검',
        type: '물리',
        twoPiecesEffect: '물리 공격력 +5%',
        fourPiecesEffect: '일반 공격 피해 20% 증가',
      ),
      const Rune(
        name: '괴물 늑대',
        type: '물리',
        twoPiecesEffect: '치명타 확률 +7%',
        fourPiecesEffect:
            '액티브 공격으로 치명타 발동 시 [전투 후] 대상 주변 1바퀴 내 적에게 고정 피해를 1회 가함(물리 공격력의 15%)',
      ),
      const Rune(
        name: '검투사',
        type: '물리',
        twoPiecesEffect: '치명타 확률 +7%',
        fourPiecesEffect:
            '액티브 공격으로 HP가 70%를 초과하는 캐릭터 공격 시 [전투 중] 가하는 피해 20% 증가',
      ),
      const Rune(
        name: '전투 도끼',
        type: '물리',
        twoPiecesEffect: '물리 관통 +5%',
        fourPiecesEffect: '가하는 피해 10% 증가, 액티브 공격 시 [전투 중] 피해 면역 10% 증가',
      ),
      const Rune(
        name: '드래곤',
        type: '물리',
        twoPiecesEffect: '물리 관통 +5%',
        fourPiecesEffect: '주변 3칸 이내 아군이 없을 시 HP 외의 모든 능력치 8% 증가',
      ),
      const Rune(
        name: '망령 기사',
        type: '물리',
        twoPiecesEffect: 'HP +5%',
        fourPiecesEffect: '''아군 사망 시 [영혼의 힘] 획득.
[영혼의 힘] : 공격 및 방어 능력치 +5%(최대 4단계)''',
      ),
      const Rune(
        name: '전투마',
        type: '물리',
        twoPiecesEffect: 'HP +5%',
        fourPiecesEffect:
            '공격을 받을 시 [전투 중] 자신의 물리 방어력 및 마법 방어력 15% 증가(턴마다 최대 1회 발동)',
      ),
      const Rune(
        name: '카이트 실드',
        type: '물리',
        twoPiecesEffect: 'HP +5%',
        fourPiecesEffect: '피해 면역 10% 증가',
      ),
      const Rune(
        name: '진정한 십자가',
        type: '마법',
        twoPiecesEffect: 'HP +5%',
        fourPiecesEffect: '치유 효과 +20%',
      ),
    ];
  }

  static RuneType getRuneType(int index, String type) {
    const pAttackOption = ['물리 공격력', '물리 피해 증가', '물리 관통', '치명타 확률', '반격 피해'];
    const mAttackOption = ['마법 공격력', '마법 피해 증가', '마법 관통', '치명타 확률', '반격 피해'];
    const defensiveOption = [
      '체력',
      '물리 방어력',
      '마법 방어력',
      '물리 피해 면역',
      '마법 피해 면역',
      '치명타 저항'
    ];
    final bool isTypeP = type == '물리';
    switch (index) {
      case 1:
        return RuneType(
            firstStatus: '$type 공격력 280',
            secondStatus: null,
            attackOption: isTypeP ? pAttackOption : mAttackOption,
            defensiveOption: defensiveOption,
            attackOptionMax: 9,
            defensiveOptionMax: 3);
      case 2:
        return RuneType(
            firstStatus: '마법 방어력 ${isTypeP ? 160 : 180}',
            secondStatus: null,
            attackOption: isTypeP ? pAttackOption : mAttackOption,
            defensiveOption: defensiveOption,
            attackOptionMax: 3,
            defensiveOptionMax: 9);
      case 3:
        return RuneType(
            firstStatus: '물리 방어력 ${isTypeP ? 200 : 140}',
            secondStatus: null,
            attackOption: isTypeP ? pAttackOption : mAttackOption,
            defensiveOption: defensiveOption,
            attackOptionMax: 3,
            defensiveOptionMax: 9);
      case 4:
        return RuneType(
            firstStatus: '$type 공격력 280',
            secondStatus: '마법 방어력 ${isTypeP ? 160 : 180}',
            attackOption: isTypeP ? pAttackOption : mAttackOption,
            defensiveOption: defensiveOption,
            attackOptionMax: 6,
            defensiveOptionMax: 6);
      case 5:
        return RuneType(
            firstStatus: '체력 ${isTypeP ? 580 : 420}',
            secondStatus:
                '$type 공격력 120, 물리 방어력 ${isTypeP ? 100 : 80}, 마법 방어력 ${isTypeP ? 80 : 100}, 집중력 200',
            attackOption: isTypeP ? pAttackOption : mAttackOption,
            defensiveOption: defensiveOption,
            attackOptionMax: 9,
            defensiveOptionMax: 3);
      case 6:
        return RuneType(
            firstStatus: '$type 공격력 280',
            secondStatus: '마법 방어력 ${type == '물리' ? 160 : 180}',
            attackOption: type == '물리' ? pAttackOption : mAttackOption,
            defensiveOption: defensiveOption,
            attackOptionMax: 6,
            defensiveOptionMax: 6);
      default:
        throw Exception('에러');
    }
  }
}
