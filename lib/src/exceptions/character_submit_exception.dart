abstract class CustomError {
  String get title;
  String get description;
}

class CharacterSameNameException extends CustomError {
  @override
  String get title => '중복 이름 존재';
  @override
  String get description => '동일한 이름을 가진 영웅이 존재합니다. 다른 이름을 입력해 주십시오.';

  @override
  String toString() {
    return '$title\n$description.';
  }
}

class AnonymousUserException extends CustomError {
  @override
  String get title => '로그인 요함';
  @override
  String get description => '로그인을 해야 입력, 수정이 가능합니다.';

  @override
  String toString() {
    return '$title\n$description.';
  }
}
