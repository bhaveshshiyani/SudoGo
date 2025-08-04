import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  final Function(int) onNumberSelected;

  const NumberPad({super.key, required this.onNumberSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.center,
        children: List.generate(9, (index) {
          final number = index + 1;
          return SizedBox(
            width: 50,
            height: 50,
            child: ElevatedButton(
              onPressed: () => onNumberSelected(number),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.zero,
                elevation: 5,
                textStyle: const TextStyle(fontSize: 24),
              ),
              child: Text(number.toString()),
            ),
          );
        }),
      ),
    );
  }
}
