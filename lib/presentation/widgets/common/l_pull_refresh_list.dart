import 'package:flutter/material.dart';

///Reusable pull-to-refresh list widget.
class LPullRefreshList<T> extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final String? emptyMessage;

  const LPullRefreshList({
    super.key,
    required this.onRefresh,
    required this.items,
    required this.itemBuilder,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child:
          items.isEmpty
              ? ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(emptyMessage ?? 'No data available'),
                    ),
                  ),
                ],
              )
              : ListView.builder(
                itemCount: items.length,
                itemBuilder:
                    (context, index) => itemBuilder(context, items[index]),
              ),
    );
  }
}
