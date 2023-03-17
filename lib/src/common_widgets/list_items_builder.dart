import 'package:archeland_encyclopedia/src/common_widgets/empty_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({
    Key? key,
    required this.data,
    required this.itemBuilder,
  }) : super(key: key);
  final AsyncValue<List<T>> data;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (items) => items.isNotEmpty
          ? ListView.separated(
              itemCount: items.length + 2,
              separatorBuilder: (context, index) => Divider(
                indent: 0,
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
              itemBuilder: (context, index) {
                if (index == 0 || index == items.length + 1) {
                  return const SizedBox.shrink();
                }
                return itemBuilder(context, items[index - 1]);
              },
            )
          : const EmptyContent(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stacktrace) => EmptyContent(
        title: '오류가 발생하였습니다.',
        message: kDebugMode ? '$error\\n$stacktrace' : '불편을 드려 죄송합니다.',
      ),
    );
  }
}
