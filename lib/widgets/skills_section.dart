import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../models/portfolio_models.dart';
import '../theme/app_colors.dart';
import 'responsive.dart';
import 'scroll_reveal.dart';
import 'section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundAlt,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
        vertical: 90,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RevealOnScroll(
                child: const SectionHeader(
                  index: '02',
                  title: 'Skills & Tools',
                  subtitle:
                      'The languages, frameworks and tools I reach for most, '
                      'grouped by how I use them.',
                ),
              ),
              const SizedBox(height: 44),
              for (int i = 0; i < PortfolioData.skills.length; i++)
                RevealOnScroll(
                  delay: Duration(milliseconds: 60 * i),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: _SkillRow(group: PortfolioData.skills[i]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillRow extends StatelessWidget {
  final SkillGroup group;
  const _SkillRow({required this.group});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final label = SizedBox(
      width: isMobile ? double.infinity : 180,
      child: Text(
        group.category.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
    final chips = Expanded(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [for (final item in group.items) _SkillChip(label: item)],
      ),
    );

    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [label, const SizedBox(height: 10), chips],
          )
        : IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [label, const SizedBox(width: 20), chips],
            ),
          );
  }
}

class _SkillChip extends StatefulWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: _hovering ? AppColors.surfaceElevated : AppColors.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: _hovering ? AppColors.coral : AppColors.border,
          ),
        ),
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _hovering ? AppColors.textPrimary : AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
