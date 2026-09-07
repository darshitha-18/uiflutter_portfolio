import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A numbered, editorial-style section heading — e.g. "02 · Projects".
class SectionHeader extends StatelessWidget {
  final String index;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.index,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              index,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.coral,
                  ),
            ),
            const SizedBox(width: 12),
            Container(width: 28, height: 1, color: AppColors.border),
          ],
        ),
        const SizedBox(height: 14),
        Text(title, style: Theme.of(context).textTheme.displayMedium),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ],
    );
  }
}
