import '../models/portfolio_models.dart';

/// Every string on this page is sourced directly from
/// Thota Bindu Darshitha's resume. Update this file to keep the
/// portfolio in sync — no other file should hard-code personal content.
class PortfolioData {
  PortfolioData._();

  static const String name = 'Thota Bindu Darshitha';
  static const String role = 'AI & ML Undergraduate';
  static const List<String> roleRotator = [
    'AI & ML Undergraduate',
    'Machine Learning Enthusiast',
    'RAG & LLM Builder',
    'UI/UX-minded Developer',
  ];

  static const String summary =
      '2nd year AI & ML undergraduate driven by curiosity to understand how '
      'intelligent systems solve real-world problems. Actively exploring '
      'end-to-end AI/ML workflows — from data engineering and model '
      'development to backend integration and deployment. Complemented by a '
      'strong creative interest in design and building visually intuitive '
      'solutions.';

  static const String email = 'bindudarshitha18@gmail.com';
  static const String github = 'github.com/darshitha-18';
  static const String githubUrl = 'https://github.com/darshitha-18';
  static const String linkedin =
      'linkedin.com/in/bindu-darshitha-a28144343';
  static const String linkedinUrl =
      'https://linkedin.com/in/bindu-darshitha-a28144343';

  static const List<EducationItem> education = [
    EducationItem(
      title: 'B.Tech in Computer Science Engineering (AI & ML)',
      place: 'CR Rao AIMSCS, University of Hyderabad Campus',
      period: '2024 – 2028',
      detail: '8.75 CGPA',
    ),
    EducationItem(
      title: 'Class I – XII',
      place: 'Narayana',
      period: '2012 – 2024',
      detail: 'Class X: 10/10 CGPA  ·  Class XII: 93%',
    ),
  ];

  static const List<SkillGroup> skills = [
    SkillGroup(
      category: 'Programming',
      items: ['Python', 'C', 'Java (OOP)', 'SQL'],
    ),
    SkillGroup(
      category: 'AI / ML',
      items: [
        'Machine Learning',
        'Deep Learning',
        'LLMs',
        'Retrieval-Augmented Generation (RAG)',
        'Audio Signal Processing',
      ],
    ),
    SkillGroup(
      category: 'Frontend & Backend',
      items: ['HTML', 'CSS', 'JavaScript', 'Flask', 'APIs'],
    ),
    SkillGroup(
      category: 'Core CS',
      items: [
        'Operating Systems',
        'DBMS',
        'Automata Theory & Compiler Design',
        'Data Structures',
      ],
    ),
    SkillGroup(
      category: 'Tools',
      items: [
        'VS Code',
        'Git',
        'GitHub',
        'LaTeX',
        'Jupyter Notebook',
        'Figma (UI/UX)',
        'Canva',
      ],
    ),
  ];

  static const List<ProjectItem> projects = [
    ProjectItem(
      title: 'Vegam — Delivery Delay Tracker',
      tagline: 'Predicting and explaining shipment delays before they happen',
      stack: 'Python · XGBoost · SHAP · Streamlit',
      badge: "TVASTR '26 Hackathon",
      highlights: [
        'Trained an XGBoost regressor to predict delivery delay severity in '
            'hours; applied a risk threshold classifier to flag high-priority '
            'shipments requiring immediate intervention, achieving 92% accuracy.',
        'Implemented TreeSHAP to decompose each prediction into key delay '
            'drivers (weather, traffic, factory variability, routing '
            'complexity), providing a transparent, auditable root-cause '
            'report per delivery.',
        'Built a multi-page Streamlit dashboard surfacing fleet-wide risk '
            'distributions, per-delivery SHAP forensics, and an optimization '
            'engine proposing rescheduling or factory swaps — converting a '
            'baseline reward of −456.2 to +2598.',
      ],
    ),
    ProjectItem(
      title: 'DocMind — Document Q&A System',
      tagline: 'A locally-grounded RAG pipeline for querying your own PDFs',
      stack: 'FastAPI · LangChain · ChromaDB · LLaMA 3',
      highlights: [
        'Built a local RAG pipeline over uploaded PDFs: text extraction, '
            'overlapping chunking, vector embeddings, and LLaMA 3.1 8B '
            '(Groq) for grounded answers with file and page source '
            'references.',
        'Supports multi-document querying with instant knowledge base '
            'updates on deletion; answers strictly grounded in uploaded '
            'content with no external knowledge.',
      ],
    ),
    ProjectItem(
      title: 'Audio Deepfake Detector',
      tagline: 'Spotting synthetic speech with self-supervised features',
      stack: 'Python · WavLM · PyTorch · Attentive Statistics Pooling',
      highlights: [
        'Built a deepfake detection system using WavLM as a self-supervised '
            'front-end, exploiting its masked speech denoising '
            'pre-training to surface speaker-related artefacts distinctive '
            'of synthetic audio.',
        'Designed a Multi-Fusion Attentive (MFA) classifier with time-wise '
            'and layer-wise ASP layers to aggregate features across all '
            'transformer layers; achieved a pooled EER of 2.56% on '
            'ASVspoof 2021 DF.',
      ],
    ),
    ProjectItem(
      title: 'Creos — Anonymous Talent Competition Platform',
      tagline: 'A fair, gamified stage for creative talent',
      stack: 'Platform Design',
      badge: "TechFest '25 — 1st Prize",
      highlights: [
        'Designed a fair, multi-talent competition platform ensuring '
            'anonymous submissions, transparent voting, and gamified '
            'engagement to recognize pure skill across creative fields.',
      ],
    ),
  ];

  static const List<CertificationItem> certifications = [
    CertificationItem(title: 'Machine Learning', issuer: 'CodeChef'),
    CertificationItem(title: 'AI Essentials', issuer: 'Coursera'),
    CertificationItem(
      title: 'Frontend Development (HTML, CSS, JavaScript)',
      issuer: 'CodeChef',
    ),
  ];

  static const List<AchievementItem> achievements = [
    AchievementItem(
      title: "1st Prize — TechFest '25",
      detail: 'Won first prize for Creos, an anonymous talent competition '
          'platform.',
    ),
    AchievementItem(
      title: "TVASTR '26 Hackathon",
      detail: 'Built Vegam, a delivery delay prediction and explainability '
          'dashboard, at the TVASTR hackathon.',
    ),
  ];
}
