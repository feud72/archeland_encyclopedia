import 'package:archeland_encyclopedia/src/features/artifacts/domain/artifact.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'artifacts_screen_controller.g.dart';

@riverpod
class ArtifactsScreenController extends _$ArtifactsScreenController {
  @override
  FutureOr<void> build() {
    //
  }

  bool _checkPropertyExistAndContain(String? property, String query) {
    return property != null && property.contains(query);
  }

  bool isQueryMatched(Artifact artifact, String query) {
    if (_checkPropertyExistAndContain(artifact.name, query) ||
        _checkPropertyExistAndContain(artifact.subName, query) ||
        _checkPropertyExistAndContain(artifact.effectName, query) ||
        _checkPropertyExistAndContain(artifact.effectDescription, query) ||
        _checkPropertyExistAndContain(artifact.weaponType, query)) {
      return true;
    }
    if (artifact.jobs != null && artifact.jobs!.isNotEmpty) {
      return artifact.jobs!
          .any((job) => _checkPropertyExistAndContain(job, query));
    }
    return false;
  }
}
