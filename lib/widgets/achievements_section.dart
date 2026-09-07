import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import 'hover_lift.dart';
import 'responsive.dart';
import 'scroll_reveal.dart';
import 'section_header.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
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
                  index: '05',
                  title: 'Achievements & Certifications',
                ),
              ),
              const SizedBox(height: 44),
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: RevealOnScroll(child: _AchievementsList()),
                  ),
                  SizedBox(
                    width: isMobile ? 0 : 48,
                    height: isMobile ? 40 : 0,
                  ),
                  Expanded(
                    flex: 4,
                    child: RevealOnScroll(
                      delay: const Duration(milliseconds: 100),
                      child: _CertificationsList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AchievementsList extends StatelessWidget {
  const _AchievementsList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ACHIEVEMENTS', style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 16),
        for (final a in PortfolioData.achievements)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: HoverLift(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.coral.withOpacity(0.10),
                      AppColors.surface,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.military_tech_rounded,
                        color: AppColors.gold, size: 26),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a.title,
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 6),
                          Text(a.detail,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _CertificationsList extends StatelessWidget {
  const _CertificationsList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CERTIFICATIONS', style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 16),
        for (final c in PortfolioData.certifications)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: HoverLift(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.workspace_premium_rounded,
                        color: AppColors.mint, size: 20),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.title,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  )),
                          const SizedBox(height: 2),
                          Text(c.issuer,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
