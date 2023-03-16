import 'package:archeland_encyclopedia/src/features/characters/presentation/characters_screen/characters_search_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharactersSearchTextField extends ConsumerStatefulWidget {
  const CharactersSearchTextField({Key? key}) : super(key: key);

  @override
  ConsumerState<CharactersSearchTextField> createState() =>
      _CharactersSearchTextFieldState();
}

class _CharactersSearchTextFieldState
    extends ConsumerState<CharactersSearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, _) {
          return TextField(
            controller: _controller,
            maxLines: 1,
            maxLength: 15,
            autofocus: false,
            decoration: InputDecoration(
              icon: const Icon(Icons.search),
              labelText: '검색',
              hintText: '이름, 특성, 스킬 등을 입력하세요.',
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _controller.clear();
                        ref
                            .read(charactersSearchQueryStateProvider.notifier)
                            .state = '';
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : null,
            ),
            onChanged: (text) => ref
                .read(charactersSearchQueryStateProvider.notifier)
                .state = text,
          );
        });
  }
}
