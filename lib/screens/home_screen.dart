import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/about_section.dart';
import '../widgets/achievements_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/education_section.dart';
import '../widgets/footer.dart';
import '../widgets/hero_section.dart';
import '../widgets/nav_bar.dart';
import '../widgets/projects_section.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/skills_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _achievementsKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ScrollRevealScope(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HeroSection(
                    onViewWork: () => _scrollTo(_projectsKey),
                    onContact: () => _scrollTo(_contactKey),
                  ),
                  KeyedSubtree(key: _aboutKey, child: const AboutSection()),
                  KeyedSubtree(key: _skillsKey, child: const SkillsSection()),
                  KeyedSubtree(
                      key: _projectsKey, child: const ProjectsSection()),
                  KeyedSubtree(
                      key: _educationKey, child: const EducationSection()),
                  KeyedSubtree(
                      key: _achievementsKey,
                      child: const AchievementsSection()),
                  KeyedSubtree(key: _contactKey, child: const ContactSection()),
                  const Footer(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: NavBar(
                items: [
                  NavItem('About', () => _scrollTo(_aboutKey)),
                  NavItem('Skills', () => _scrollTo(_skillsKey)),
                  NavItem('Projects', () => _scrollTo(_projectsKey)),
                  NavItem('Education', () => _scrollTo(_educationKey)),
                  NavItem('Achievements', () => _scrollTo(_achievementsKey)),
                  NavItem('Contact', () => _scrollTo(_contactKey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
