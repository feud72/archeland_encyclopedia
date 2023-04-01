import 'package:archeland_encyclopedia/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationWidget extends ConsumerWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: user != null
                ? [
                    const Text('아르케랜드 도감을 사용해 주셔서 감사합니다.'),
                    const SizedBox(height: 24),
                    Text(
                        '본 도감 앱은 이용자 모두가 참여해 채워 나가는 공간입니다. ${user.displayName} 님의 공헌에 깊은 감사를 드립니다.'),
                    const SizedBox(height: 24),
                    const Text(
                        '항목을 악의적으로 편집을 하는 행위를 자제해 주시길 미리 부탁을 드립니다. 게임 내용과 관련이 없거나 부적절한 내용을 반복적으로 게시하는 경우, 운영자의 판단에 따라 앱의 이용이 제한될 수 있습니다.'),
                    const SizedBox(height: 24),
                  ]
                : [
                    const Text(
                        '본 도감은 아르케랜드 게임 내 정보를 편하게 검색, 조회 하기 위하여 제작하였습니다.'),
                    const SizedBox(height: 24),
                    const Text('- 읽기 : 로그인 없이 모든 데이터를 읽을 수 있습니다.'),
                    const SizedBox(height: 24),
                    const Text('- 데이터 추가, 편집 : 로그인이 필요합니다.'),
                  ]),
      ),
    );
  }
}
