import 'package:flutter/material.dart';

class SortByDialogue extends StatefulWidget {
  final String selectedSort;
  final Function(String) onSortSelected;
  const SortByDialogue({
    super.key,
    required this.selectedSort,
    required this.onSortSelected,
  });

  @override
  State<SortByDialogue> createState() => _SortByDiaogueState();
}

class _SortByDiaogueState extends State<SortByDialogue> {
  String? selectedOption;

  final List<String> sortOptions = [
    "Relevance",
    "Popularity",
    "Price -- Low to High",
    "Price -- High to Low",
    "Newest First",
  ];
  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedSort;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "SORT BY",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Divider(),
          Column(
            children:
                sortOptions.map((option) {
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                      widget.onSortSelected(value!);
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
