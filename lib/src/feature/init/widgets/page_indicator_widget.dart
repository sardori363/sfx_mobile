import 'package:flutter/material.dart';

class PageIndicatorWidget extends StatelessWidget {
  const PageIndicatorWidget({
    super.key,
    required this.currentValue,
  });
  final int currentValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: AnimatedContainer(
              curve: Curves.easeIn,
              width: index == currentValue ? 32 : 8,
              decoration: BoxDecoration(
                color: index == currentValue ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              duration: const Duration(
                milliseconds: 300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
