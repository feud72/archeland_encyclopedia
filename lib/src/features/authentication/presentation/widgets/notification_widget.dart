import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('본 도감은 아르케랜드 게임 내 정보를 편하게 검색, 조회 하기 위하여 제작하였습니다.'),
        SizedBox(height: 24),
        Text(
            '이용자 모두가 참여하여 채워 나가는 공간입니다. 악의적인 편집을 자제해 주시길 부탁드립니다. 게임 내용과 관련 없는 부적절한 내용을 반복적으로 게시하는 경우, 판단에 따라 이용이 제한될 수 있습니다.'),
        SizedBox(height: 24),
        Text('- 읽기 : 로그인 없이 모든 데이터를 읽을 수 있습니다.'),
        Text('- 쓰기 : 로그인이 필요합니다.'),
      ],
    );
  }
}
