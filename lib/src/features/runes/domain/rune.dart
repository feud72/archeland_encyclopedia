import 'package:freezed_annotation/freezed_annotation.dart';

part 'rune.freezed.dart';
part 'rune.g.dart';

@freezed
class Rune with _$Rune {
  const factory Rune({
    required String name,
    required String type,
    required String twoPiecesEffect,
    required String fourPiecesEffect,
  }) = _Rune;

  factory Rune.fromJson(Map<String, dynamic> json) => _$RuneFromJson(json);
}
