import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandScreen extends ConsumerWidget {
  const LandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('업데이트 예정입니다.', style: Theme.of(context).textTheme.titleLarge),
        Text(
          '예정 내용',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        ...['본성 업그레이드', '정원', '아카데미', '벨렛의 공들인 기획'].map((e) => Text(e)),
      ],
    );
  }
}
