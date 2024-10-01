import 'package:flutter/material.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.localized.no_tests_text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(
          color: context.colorScheme.onPrimary
        ),
      ),
    );
  }
}
