import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  FilterWidget({
    required this.filters,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: () {
        _showFilterOptions(context);
      },
    );
  }

  void _showFilterOptions(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromSize(
        Rect.fromPoints(
          Offset(MediaQuery.of(context).size.width - 100, 60),
          Offset(MediaQuery.of(context).size.width - 20, 80),
        ),
        Size(MediaQuery.of(context).size.width, 40),
      ),
      items: [
        for (int i = 0; i < filters.length; i++)
          PopupMenuItem(
            value: i,
            child: Text(filters[i]),
          ),
      ],
    ).then((value) {
      if (value != null) {
        onItemSelected(value);
      }
    });
  }
}
