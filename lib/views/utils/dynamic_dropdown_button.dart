import 'package:flutter/material.dart';

// class DynamicDropdownButton extends StatelessWidget {
//   final List<DropdownMenuItem<String>> items;
//   final void Function(String?) onChanged;
//   final String buttonText;
//   final TextStyle buttonTextStyle;

//   const DynamicDropdownButton({
//     Key? key,
//     required this.items,
//     required this.onChanged,
//     required this.buttonText,
//     required this.buttonTextStyle,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(minimumSize: Size(double.maxFinite, 50)),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: null,
//           icon: null,
//           items: items,
//           onChanged: onChanged,
//         ),
//       ),
//       // child: Text(
//       //   buttonText,
//       //   style: buttonTextStyle,
//       // ),
//     );
//   }
// }


class DynamicDropdownButton extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;
  final String buttonText;
  final TextStyle buttonTextStyle;

  const DynamicDropdownButton({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.buttonText,
    required this.buttonTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.maxFinite, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonText,
            style: buttonTextStyle,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: null,
              icon: null,
              items: items,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

