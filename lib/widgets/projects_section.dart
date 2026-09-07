import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import 'project_card.dart';
import 'responsive.dart';
import 'scroll_reveal.dart';
import 'section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.isDesktop(context)
        ? 2
        : Responsive.isTablet(context)
            ? 2
            : 1;

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
                  index: '03',
                  title: 'Projects',
                  subtitle:
                      'A mix of applied ML, generative AI and systems work — '
                      'tap a card to see the details.',
                ),
              ),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  final gap = 24.0;
                  final cardWidth = columns == 1
                      ? constraints.maxWidth
                      : (constraints.maxWidth - gap * (columns - 1)) / columns;
                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: [
                      for (int i = 0; i < PortfolioData.projects.length; i++)
                        SizedBox(
                          width: cardWidth,
                          child: RevealOnScroll(
                            delay: Duration(milliseconds: 70 * i),
                            child: ProjectCard(
                              project: PortfolioData.projects[i],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
