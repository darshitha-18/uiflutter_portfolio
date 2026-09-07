/// Simple immutable data models backing every section of the portfolio.
/// Kept in one file since they are small and tightly related.

class ProjectItem {
  final String title;
  final String tagline;
  final String stack;
  final List<String> highlights;
  final String? badge; // e.g. hackathon / award tag

  const ProjectItem({
    required this.title,
    required this.tagline,
    required this.stack,
    required this.highlights,
    this.badge,
  });
}

class SkillGroup {
  final String category;
  final List<String> items;

  const SkillGroup({required this.category, required this.items});
}

class EducationItem {
  final String title;
  final String place;
  final String period;
  final String detail;

  const EducationItem({
    required this.title,
    required this.place,
    required this.period,
    required this.detail,
  });
}

class CertificationItem {
  final String title;
  final String issuer;

  const CertificationItem({required this.title, required this.issuer});
}

class AchievementItem {
  final String title;
  final String detail;

  const AchievementItem({required this.title, required this.detail});
}
