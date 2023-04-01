import 'package:archeland_encyclopedia/src/features/search/query_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchTextField extends ConsumerStatefulWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends ConsumerState<SearchTextField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = ref.read(queryProvider);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(queryProvider);
    return WillPopScope(
      onWillPop: () {
        if (query.isNotEmpty) {
          ref.read(queryProvider.notifier).state = "";
          _controller.clear();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, value, _) {
              return TextField(
                controller: _controller,
                maxLines: 1,
                maxLength: 15,
                autofocus: false,
                decoration: InputDecoration(
                  isDense: true,
                  counterText: "",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.search),
                  labelText: '검색',
                  hintText: '검색어를 입력하세요.',
                  suffixIcon: value.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _controller.clear();
                            ref.read(queryProvider.notifier).state = '';
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
                onChanged: (text) =>
                    ref.read(queryProvider.notifier).state = text,
              );
            }),
      ),
    );
  }
}
