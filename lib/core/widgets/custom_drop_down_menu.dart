import 'package:flutter/material.dart';




class CustomDropdownMenu extends StatefulWidget{
  final String hintText;
  final String? value;
  final List<String> options;
  final Color textColor;
  final Color dropdownColor;
  final Color iconColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Function(String?) onChange;
  final Function(String)? onTap;


  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();


  CustomDropdownMenu({
      required this.hintText,
      required this.options,
      required this.onChange,
      this.textColor = Colors.black,
      this.dropdownColor = Colors.white,
      this.iconColor = Colors.black,
      this.fontSize=20,
    this.fontWeight= FontWeight.w600,
     this.onTap,
    this.value,



  });
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.dropdownColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1)
      ),
      child: DropdownButton(

        elevation: 0,
        iconSize: 35,
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(widget.hintText,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
              color: widget.textColor,
            ),
          ),
        ),
        style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          color: widget.textColor,
        ),
        icon: Icon(Icons.arrow_drop_down, color: widget.iconColor),
        value:widget.options.contains(selectedValue) ? selectedValue : null,

        dropdownColor: widget.dropdownColor,
          items: widget.options.map<DropdownMenuItem<String>>((option) {
            return DropdownMenuItem<String>(
              value: option.toString(),
              child: Text(option.toString()),
            );
          }).toList(),

        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              selectedValue = newValue;
            });

            widget.onChange(newValue);
            widget.onTap!(newValue);
          }
        },



      ),
    );
  }
}