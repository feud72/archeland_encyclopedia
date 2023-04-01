import 'package:archeland_encyclopedia/src/features/artifacts/domain/artifact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'artifact_provider.g.dart';

@Riverpod(keepAlive: true)
CollectionReference<Artifact> weapons(WeaponsRef ref) {
  return FirebaseFirestore.instance.collection('weapons').withConverter(
      fromFirestore: (snapshot, _) => Artifact.fromJson(snapshot.data()!),
      toFirestore: (weapon, _) => weapon.toJson());
}

@Riverpod(keepAlive: true)
CollectionReference<Artifact> helmets(HelmetsRef ref) {
  return FirebaseFirestore.instance.collection('helmets').withConverter(
      fromFirestore: (snapshot, _) => Artifact.fromJson(snapshot.data()!),
      toFirestore: (helmet, _) => helmet.toJson());
}

@Riverpod(keepAlive: true)
CollectionReference<Artifact> armors(ArmorsRef ref) {
  return FirebaseFirestore.instance.collection('armors').withConverter(
      fromFirestore: (snapshot, _) => Artifact.fromJson(snapshot.data()!),
      toFirestore: (armor, _) => armor.toJson());
}

@Riverpod(keepAlive: true)
CollectionReference<Artifact> accessories(AccessoriesRef ref) {
  return FirebaseFirestore.instance.collection('accessories').withConverter(
      fromFirestore: (snapshot, _) => Artifact.fromJson(snapshot.data()!),
      toFirestore: (accessory, _) => accessory.toJson());
}
