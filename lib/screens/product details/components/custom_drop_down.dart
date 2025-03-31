import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> dropDownValues;
  final String? value;
  final Function(String?) onChanged;
  const CustomDropDown({
    super.key,
    required this.dropDownValues,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.height * 0.17,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade400,
        ), // Red border like the image
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text("Select Size", style: TextStyle(fontSize: 16)),
          isExpanded: true,

          icon: Icon(Icons.arrow_drop_down),
          items:
              dropDownValues
                  .map(
                    (size) => DropdownMenuItem(value: size, child: Text(size)),
                  )
                  .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
