import 'package:archeland_encyclopedia/src/common_widgets/error_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T) data;

  const AsyncValueWidget({super.key, required this.value, required this.data});

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) => Center(child: ErrorMessageWidget(e.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class ScaffoldAsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T) data;

  const ScaffoldAsyncValueWidget(
      {super.key, required this.value, required this.data});

  @override
  Widget build(BuildContext context) {
    return value.when(
        data: data,
        error: (e, st) => Scaffold(
              appBar: AppBar(),
              body: Center(
                child: ErrorMessageWidget(e.toString()),
              ),
            ),
        loading: () => Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}
