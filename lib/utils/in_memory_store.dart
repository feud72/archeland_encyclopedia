import 'package:rxdart/rxdart.dart';

class MemoryStore<T> {
  MemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);
  final BehaviorSubject<T> _subject;

  Stream<T> get stream => _subject.stream;
  T get value => _subject.value;
  set value(T value) => _subject.add(value);
}
