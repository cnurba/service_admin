import 'package:flutter/material.dart';

class GenericSearchDelegate<T> extends SearchDelegate {
  final List<T> items;
  final String Function(T) getLabel;
  final Widget Function(T) buildResultItem;

  GenericSearchDelegate({
    required this.items,
    required this.getLabel,
    required this.buildResultItem,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear_rounded),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back_ios_new),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = items
        .where(
          (item) => getLabel(item).toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => buildResultItem(results[index]),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = items
        .where(
          (item) => getLabel(item).toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return ListTile(
          title: Text(getLabel(item)),
          onTap: () {
            query = getLabel(item);
            showResults(context);
          },
        );
      },
    );
  }
}
