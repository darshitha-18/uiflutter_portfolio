import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import 'responsive.dart';
import 'scroll_reveal.dart';
import 'section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
        vertical: 90,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: RevealOnScroll(
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(flex: 4, child: SectionHeader(
                        index: '01',
                        title: 'About Me',
                      )),
                      const SizedBox(width: 60),
                      Expanded(flex: 6, child: _Body()),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SectionHeader(index: '01', title: 'About Me'),
                      SizedBox(height: 28),
                      _Body(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioData.summary,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontSize: 17, color: AppColors.textPrimary.withOpacity(0.9)),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _FactChip(label: 'CGPA', value: '8.75'),
            _FactChip(label: 'Year', value: '2nd Year'),
            _FactChip(label: 'Branch', value: 'CSE (AI & ML)'),
            _FactChip(label: 'Focus', value: 'RAG · LLMs · ML'),
          ],
        ),
      ],
    );
  }
}

class _FactChip extends StatelessWidget {
  final String label;
  final String value;
  const _FactChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.mint),
          ),
        ],
      ),
    );
  }
}
