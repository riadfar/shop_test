import 'package:flutter/material.dart';
import 'package:rightware_test/core/localization/app_localizations.dart';

class OrDivider extends StatelessWidget {
  final Color onSurface;

  const OrDivider({super.key, required this.onSurface});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(child: Divider(color: onSurface.withOpacity(0.14), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            context.tr('or_continue_with'),
            style: textTheme.labelSmall?.copyWith(
              color: onSurface.withOpacity(0.38),
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(child: Divider(color: onSurface.withOpacity(0.14), thickness: 1)),
      ],
    );
  }
}