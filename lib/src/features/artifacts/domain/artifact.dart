import 'package:freezed_annotation/freezed_annotation.dart';

part 'artifact.freezed.dart';
part 'artifact.g.dart';

@freezed
class Artifact with _$Artifact {
  const factory Artifact({
    required String name,
    String? subName,
    String? weaponType,
    required String effectName,
    required String effectDescription,
    List<String>? jobs,
  }) = _Artifact;

  factory Artifact.fromJson(Map<String, dynamic> json) =>
      _$ArtifactFromJson(json);
}
