import 'dart:math';

import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';

final maxStatus = [
  1900,
  240,
  1200,
  1200,
  4500,
  1900,
];
final minStatus = [
  900,
  40,
  200,
  200,
  2000,
  900,
];
final angleMul = [7, 9, 1, 3, 5, 7];
final statusPropertyList = [
  '공격력',
  '집중력',
  '물리 방어력',
  '마법 방어력',
  'HP',
  '공격력',
];

bool isStatusDrawable(List<String?> statusList) {
  return statusList
      .every((status) => status != null && int.tryParse(status) != null);
}

List<int>? parseIntCharacterStatus(List<String?> statusList) {
  if (isStatusDrawable(statusList)) {
    return statusList.map((status) => int.parse(status!)).toList();
  }
  return null;
}

Offset calculateOffset(int index, double radius, Offset center,
    {double multiplier = 1}) {
  return Offset(
    multiplier * radius * cos(pi * 2 * (36 * angleMul[index] + 18) / 360) +
        center.dx,
    multiplier * radius * sin(pi * 2 * (36 * angleMul[index] + 18) / 360) +
        center.dy,
  );
}

String? calculateAtk({String? pAtk, String? mAtk}) {
  if (pAtk == null || mAtk == null) return null;
  final pAtkToInt = int.tryParse(pAtk);
  final mAtkToInt = int.tryParse(mAtk);
  if (pAtkToInt != null && mAtkToInt != null) {
    return max(pAtkToInt, mAtkToInt).toString();
  }
  if (pAtk == 'S') {
    return pAtk;
  } else if (mAtk == 'S') {
    return mAtk;
  } else {
    return pAtk.compareTo(mAtk) < 0 ? pAtk : mAtk;
  }
}

class CharacterStatusHexagonWidget extends StatelessWidget {
  const CharacterStatusHexagonWidget({
    Key? key,
    required this.screenWidth,
    required this.character,
  }) : super(key: key);

  final Character character;
  final double screenWidth;
  double get diameter => screenWidth - 100;
  double get radius => diameter / 2;

  @override
  Widget build(BuildContext context) {
    final bool isDrawble = character.hp != null &&
        character.pAtk != null &&
        character.mAtk != null &&
        character.pDef != null &&
        character.mDef != null &&
        character.concentration != null;
    return isDrawble
        ? ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: screenWidth, maxHeight: screenWidth),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Labels(
                    diameter: diameter, radius: radius, character: character),
                CustomPaint(
                  painter: HexagonPainter(radius: radius),
                ),
                CustomPaint(
                  painter: CharacterHexagonPainter(
                    color: Colors.red,
                    character: character,
                    radius: radius,
                    isBold: true,
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "문제가 발생하여 그래프를 그릴 수 없습니다.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          );
  }
}

class Labels extends StatelessWidget {
  const Labels(
      {Key? key,
      required this.character,
      required this.diameter,
      required this.radius})
      : super(key: key);

  final Character character;
  final double diameter, radius;

  @override
  Widget build(BuildContext context) {
    final center = Offset(diameter / 2 + 50, diameter / 2 + 50);
    final style = Theme.of(context).textTheme.titleSmall;
    const textAlign = TextAlign.center;

    final characterStatusList = [
      calculateAtk(pAtk: character.pAtk, mAtk: character.mAtk),
      character.concentration,
      character.pDef,
      character.mDef,
      character.hp,
      calculateAtk(pAtk: character.pAtk, mAtk: character.mAtk),
    ];

    final children = <Widget>[];

    for (int i = 0; i < 5; i++) {
      for (int j = 1; j <= 4; j++) {
        children.add(
          Positioned.fromRect(
              rect: Rect.fromCenter(
                center: calculateOffset(i, radius, center, multiplier: j / 5),
                width: 100,
                height: 41,
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      (minStatus[i] + (maxStatus[i] - minStatus[i]) * j ~/ 5)
                          .toString()
                          .hardcoded,
                      textAlign: textAlign,
                      style: style?.copyWith(
                          color: Colors.grey.withOpacity(0.5),
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              )),
        );
      }
      children.add(
        Positioned.fromRect(
            rect: Rect.fromCenter(
              center: calculateOffset(i, radius, center),
              width: 100,
              height: 41,
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    statusPropertyList[i].hardcoded,
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    characterStatusList[i]!.hardcoded,
                    textAlign: textAlign,
                    style: style,
                  ),
                ],
              ),
            )),
      );
    }
    return Stack(
      children: children,
    );
  }
}

class CharacterHexagonPainter extends CustomPainter {
  final double radius;
  final bool isBold;
  final Character character;
  final Color color;

  CharacterHexagonPainter({
    required this.character,
    required this.radius,
    required this.color,
    this.isBold = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint borderPaint = Paint()
      ..color = color.withOpacity(0.8)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = isBold ? 3.0 : 1.0;
    final center = Offset(size.width / 2, size.width / 2);

    final statusList = [
      calculateAtk(pAtk: character.pAtk, mAtk: character.mAtk),
      character.concentration,
      character.pDef,
      character.mDef,
      character.hp,
      calculateAtk(pAtk: character.pAtk, mAtk: character.mAtk),
    ];
    final isDrawable = isStatusDrawable(statusList);
    if (isDrawable) {
      final characterStatus = parseIntCharacterStatus(statusList) as List<int>;
      for (int i = 0; i < 5; i++) {
        canvas.drawLine(
          calculateOffset(i, radius, center,
              multiplier: max(
                  (characterStatus[i] - minStatus[i]) /
                      (maxStatus[i] - minStatus[i]),
                  0)),
          calculateOffset(i + 1, radius, center,
              multiplier: max(
                  (characterStatus[i + 1] - minStatus[i + 1]) /
                      (maxStatus[i + 1] - minStatus[i + 1]),
                  0)),
          borderPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HexagonPainter extends CustomPainter {
  HexagonPainter({required this.radius});

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    Paint borderPaint = Paint()
      ..color = Colors.blueGrey.withOpacity(0.2)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final center = Offset(size.width / 2, size.width / 2);
    for (int j = 1; j <= 5; j++) {
      for (int i = 0; i < 5; i++) {
        canvas.drawLine(
          calculateOffset(i, radius, center, multiplier: j / 5),
          calculateOffset(i + 1, radius, center, multiplier: j / 5),
          borderPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
