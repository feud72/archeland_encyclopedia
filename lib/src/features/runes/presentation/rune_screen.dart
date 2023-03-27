import 'package:archeland_encyclopedia/src/common_widgets/custom_divider.dart';
import 'package:archeland_encyclopedia/src/features/runes/data/rune_repository.dart';
import 'package:archeland_encyclopedia/src/features/runes/domain/rune.dart';
import 'package:flutter/material.dart';

class RuneScreen extends StatefulWidget {
  const RuneScreen({Key? key}) : super(key: key);

  @override
  State<RuneScreen> createState() => _RuneScreenState();
}

class _RuneScreenState extends State<RuneScreen>
    with SingleTickerProviderStateMixin {
  final runes = RuneRepository.getRunes();

  List<Tab> tabs = <Tab>[
    const Tab(text: '홈'),
    ...RuneRepository.getRunes()
        .map((rune) => Tab(
              text: rune.name,
            ))
        .toList()
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          tabs: tabs,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RuneListWidget(controller: _tabController),
          ...runes.map((rune) => RuneWidget(
                rune: rune,
                controller: _tabController,
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        tooltip: '룬 리스트 화면으로 이동합니다.',
        onPressed: () => _tabController.animateTo(0),
        child: Icon(
          Icons.home,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}

class RuneListWidget extends StatelessWidget {
  const RuneListWidget({Key? key, required this.controller}) : super(key: key);

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final runes = RuneRepository.getRunes();
    return SingleChildScrollView(
      child: Column(
        children: [
          ...runes.map((rune) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListTile(
                onTap: () => controller.animateTo(runes.indexOf(rune) + 1),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                leading: Image.asset(
                  rune.image!,
                  width: 40,
                  height: 40,
                ),
                title: Text(
                  rune.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                iconColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                tileColor: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class RuneWidget extends StatelessWidget {
  const RuneWidget({Key? key, required this.rune, required this.controller})
      : super(key: key);
  final Rune rune;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            rune.image != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        rune.image!,
                        width: 200,
                        height: 200,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  rune.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text('${rune.type} 타입'),
              ],
            ),
            const AppDivider(),
            Text(
              '2세트 : ${rune.twoPiecesEffect}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 4.0),
            Text(
              '4세트 : ${rune.fourPiecesEffect}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 4.0),
            RuneStatusWidget(
              name: rune.name,
              type: rune.type,
            ),
            const SizedBox(
              height: 64,
            ),
          ],
        ),
      ),
    );
  }
}

class RuneStatusWidget extends StatefulWidget {
  const RuneStatusWidget({
    super.key,
    required this.type,
    required this.name,
  });

  final String name;
  final String type;

  @override
  State<RuneStatusWidget> createState() => _RuneStatusWidgetState();
}

class _RuneStatusWidgetState extends State<RuneStatusWidget> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    final List<int> countingList = [1, 2, 3, 4, 5, 6];
    final List<String> romanCharacterList = ['Ⅰ', 'Ⅱ', 'Ⅲ', 'Ⅳ', 'Ⅴ', 'Ⅵ'];
    final runeStatus = RuneRepository.getRuneType(_index, widget.type);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            ...countingList.map(
              (index) => Expanded(
                  child: TextButton(
                      onPressed: () {
                        setState(() => _index = index);
                      },
                      style: _index == index
                          ? TextButton.styleFrom()
                          : TextButton.styleFrom(foregroundColor: Colors.grey),
                      child: Text(romanCharacterList[index - 1]))),
            )
          ],
        ),
        Text(
          '주 옵션',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const AppDivider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...runeStatus.firstStatus.map((status) => Text(
                          status,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              runeStatus.secondStatus != null
                  ? Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...?runeStatus.secondStatus?.map((status) => Text(
                              status,
                              style: Theme.of(context).textTheme.bodyLarge,
                            )),
                      ],
                    ))
                  : const SizedBox.shrink(),
            ]),
        const CustomTransparentDivider(),
        Text(
          '부 옵션',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const AppDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: runeStatus.attackOption
                    .map((stat) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              stat,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              '~ +${runeStatus.attackOptionMax}%',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ],
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: runeStatus.defensiveOption
                    .map((stat) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              stat,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              '~ +${runeStatus.defensiveOptionMax}%',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        )
      ],
    );
  }
}
