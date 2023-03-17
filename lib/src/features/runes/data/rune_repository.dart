import 'package:archeland_encyclopedia/src/features/runes/domain/rune.dart';
import 'package:archeland_encyclopedia/src/features/runes/domain/rune_type.dart';

class RuneRepository {
  static List<Rune> getRunes() {
    return [
      const Rune(
        name: '검투사',
        type: '물리',
        image: 'assets/images/runes/검투사.png',
        twoPiecesEffect: '치명타 확률 +7%',
        fourPiecesEffect:
            '액티브 공격으로 HP가 70%를 초과하는 캐릭터 공격 시 [전투 중] 가하는 피해 20% 증가',
      ),
      const Rune(
        name: '괴물 늑대',
        type: '물리',
        image: 'assets/images/runes/괴물늑대.png',
        twoPiecesEffect: '치명타 확률 +7%',
        fourPiecesEffect:
            '액티브 공격으로 치명타 발동 시 [전투 후] 대상 주변 1바퀴 내 적에게 고정 피해를 1회 가함(물리 공격력의 15%)',
      ),
      const Rune(
        name: '구리 지팡이',
        type: '마법',
        image: 'assets/images/runes/구리지팡이.png',
        twoPiecesEffect: '마법 공격력 +5%',
        fourPiecesEffect: '스킬 사용 시 가하는 피해 10% 증가. 범위 스킬 사용 시 가하는 피해 추가로 5% 증가',
      ),
      const Rune(
        name: '드래곤',
        type: '물리',
        image: 'assets/images/runes/드래곤.png',
        twoPiecesEffect: '물리 관통 +5%',
        fourPiecesEffect: '주변 3칸 이내 아군이 없을 시 HP 외의 모든 능력치 8% 증가',
      ),
      const Rune(
        name: '마법의 눈',
        type: '마법',
        image: 'assets/images/runes/마법의눈.png',
        twoPiecesEffect: '마법 공격력 +5%',
        fourPiecesEffect: '피해를 가한 후 50% 확률로 대상에게 1개의 랜덤 [디버프] 부여.',
      ),
      const Rune(
        name: '망령 기사',
        type: '물리',
        image: 'assets/images/runes/망령기사.png',
        twoPiecesEffect: 'HP +5%',
        fourPiecesEffect: '''아군 사망 시 [영혼의 힘] 획득.
[영혼의 힘] : 공격 및 방어 능력치 +5%(최대 4단계)''',
      ),
      const Rune(
        name: '모래시계',
        type: '마법',
        image: 'assets/images/runes/모래시계.png',
        twoPiecesEffect: '마법 관통 +5%',
        fourPiecesEffect: '피해 스킬을 사용할 때마다 50% 확률로 해당 스킬 쿨타임 2 감소',
      ),
      const Rune(
        name: '설송',
        type: '마법',
        image: 'assets/images/runes/설송.png',
        twoPiecesEffect: 'HP +5%',
        fourPiecesEffect:
            '''액티브 공격 시 [전투 전] 50% 확률로 대상에게 [둔화II] 및 [마력 침식] 상태 부여. 1턴간 지속
[둔화II] : 이동력 -2. 호위 불가.
[마력 침식] : 마법 방어력 -30%''',
      ),
      const Rune(
        name: '성검',
        type: '물리',
        image: 'assets/images/runes/성검.png',
        twoPiecesEffect: '물리 공격력 +5%',
        fourPiecesEffect: '일반 공격 피해 20% 증가',
      ),
      const Rune(
        name: '세계수',
        type: '마법',
        image: 'assets/images/runes/세계수.png',
        twoPiecesEffect: 'HP +5%',
        fourPiecesEffect: '아군에게 스킬 사용 후 40% 확률로 대상이 랜덤 [버프] 1개 획득.',
      ),
      const Rune(
        name: '우로보로스',
        type: '마법',
        image: 'assets/images/runes/우로보로스.png',
        twoPiecesEffect: 'HP +5%',
        fourPiecesEffect: '''액티브 공격으로 피해를 가할 시 [전투 후] [중독] 상태를 부여. 1턴간 지속
[중독] : 행동 종료 시 HP를 5% 잃고 1칸 이동할 때마다 추가로 HP를 5%를 잃음(최대 15%)''',
      ),
      const Rune(
        name: '전투 도끼',
        type: '물리',
        image: 'assets/images/runes/전투도끼.png',
        twoPiecesEffect: '물리 관통 +5%',
        fourPiecesEffect: '가하는 피해 10% 증가, 액티브 공격 시 [전투 중] 피해 면역 10% 증가',
      ),
      const Rune(
        name: '전투마',
        type: '물리',
        image: 'assets/images/runes/전투마.png',
        twoPiecesEffect: 'HP +5%',
        fourPiecesEffect:
            '공격을 받을 시 [전투 중] 자신의 물리 방어력 및 마법 방어력 15% 증가(턴마다 최대 1회 발동)',
      ),
      const Rune(
        name: '진정한 십자가',
        type: '마법',
        image: 'assets/images/runes/진정한십자가.png',
        twoPiecesEffect: 'HP +5%',
        fourPiecesEffect: '치유 효과 +20%',
      ),
      const Rune(
        name: '카이트 실드',
        type: '물리',
        image: 'assets/images/runes/카이트실드.png',
        twoPiecesEffect: 'HP +5%',
        fourPiecesEffect: '피해 면역 10% 증가',
      ),
      const Rune(
        name: '흡혈귀',
        type: '물리',
        image: 'assets/images/runes/흡혈귀.png',
        twoPiecesEffect: '물리 공격력 +5%',
        fourPiecesEffect: '액티브 공격 시 [전투 후] HP  20% 회복',
      ),
    ]..sort(
        (a, b) => a.name.compareTo(b.name),
      );
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
            firstStatus: ['$type 공격력 280'],
            secondStatus: null,
            attackOption: isTypeP ? pAttackOption : mAttackOption,
            defensiveOption: defensiveOption,
            attackOptionMax: 9,
            defensiveOptionMax: 3);
      case 2:
        return isTypeP
            ? const RuneType(
                firstStatus: ['마법 방어력 160'],
                secondStatus: null,
                attackOption: pAttackOption,
                defensiveOption: defensiveOption,
                attackOptionMax: 3,
                defensiveOptionMax: 9)
            : const RuneType(
                firstStatus: ['마법 방어력 180'],
                secondStatus: null,
                attackOption: mAttackOption,
                defensiveOption: defensiveOption,
                attackOptionMax: 3,
                defensiveOptionMax: 9);
      case 3:
        return isTypeP
            ? const RuneType(
                firstStatus: ['물리 방어력 200'],
                secondStatus: null,
                attackOption: pAttackOption,
                defensiveOption: defensiveOption,
                attackOptionMax: 3,
                defensiveOptionMax: 9)
            : const RuneType(
                firstStatus: ['물리 방어력 140'],
                secondStatus: null,
                attackOption: mAttackOption,
                defensiveOption: defensiveOption,
                attackOptionMax: 3,
                defensiveOptionMax: 9);
      case 4:
        return isTypeP
            ? const RuneType(
                firstStatus: [
                    '체력 580',
                    '물리 공격력 120',
                    '물리 방어력 100',
                    '마법 방어력 80'
                  ],
                secondStatus: null,
                attackOption: pAttackOption,
                defensiveOption: defensiveOption,
                attackOptionMax: 6,
                defensiveOptionMax: 6)
            : const RuneType(
                firstStatus: [
                    '체력 420',
                    '마법 공격력 120',
                    '물리 방어력 80',
                    '마법 방어력 100'
                  ],
                secondStatus: null,
                attackOption: mAttackOption,
                defensiveOption: defensiveOption,
                attackOptionMax: 6,
                defensiveOptionMax: 6);
      case 5:
        return isTypeP
            ? const RuneType(
                firstStatus: [
                    '체력 580'
                  ],
                secondStatus: [
                    '물리 공격력 120',
                    '물리 방어력 100',
                    '마법 방어력 80',
                    '집중력 200',
                  ],
                attackOption: pAttackOption,
                defensiveOption: defensiveOption,
                attackOptionMax: 9,
                defensiveOptionMax: 3)
            : const RuneType(
                firstStatus: [
                    '체력 420'
                  ],
                secondStatus: [
                    '마법 공격력 120',
                    '물리 방어력 80',
                    '마법 방어력 100',
                    '집중력 200',
                  ],
                attackOption: mAttackOption,
                defensiveOption: defensiveOption,
                attackOptionMax: 9,
                defensiveOptionMax: 3);

      case 6:
        return isTypeP
            ? const RuneType(
                firstStatus: [
                    '체력 580'
                  ],
                secondStatus: [
                    '물리 공격력 120',
                    '물리 방어력 100',
                    '마법 방어력 80',
                    '집중력 저항 300',
                  ],
                attackOption: pAttackOption,
                defensiveOption: defensiveOption,
                attackOptionMax: 6,
                defensiveOptionMax: 6)
            : const RuneType(
                firstStatus: [
                    '체력 420'
                  ],
                secondStatus: [
                    '마법 공격력 120',
                    '물리 방어력 80',
                    '마법 방어력 100',
                    '집중력 300',
                  ],
                attackOption: mAttackOption,
                defensiveOption: defensiveOption,
                attackOptionMax: 6,
                defensiveOptionMax: 6);

      default:
        throw Exception('에러');
    }
  }
}
