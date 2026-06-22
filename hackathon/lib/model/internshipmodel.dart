class InternshipModel {
  final String company;
  final String role;
  final String location;
  final String duration;
  final String stipend;
  final String applyUrl;
  final String workMode; // "Remote" | "Hybrid" | "On-site"
  final String icon;

  InternshipModel({
    required this.company,
    required this.role,
    required this.location,
    required this.duration,
    required this.stipend,
    required this.applyUrl,
    this.workMode = "On-site",
    this.icon = "",
  });

  factory InternshipModel.fromJson(Map<String, dynamic> json) {
    final url = (json['applyUrl'] ?? '').toString().trim();
    final companyName = (json['company'] ?? 'Unknown').toString();

    return InternshipModel(
      company: companyName,
      role: (json['role'] ?? 'Internship').toString(),
      location: (json['location'] ?? 'India').toString(),
      duration: (json['duration'] ?? '').toString(),
      stipend: (json['stipend'] ?? 'Unpaid').toString(),
      applyUrl: url,
      workMode: (json['workMode'] ?? 'On-site').toString(),
      // Pass the company name directly into the logo helper
      icon: _logoFromUrl(url, companyName),
    );
  }

  // Uses the company name to fetch the correct domain logo, bypassing job board URLs
  static String _logoFromUrl(String url, String companyName) {
    try {
      final cleanCompany = companyName.toLowerCase().trim();

      // 1. Direct dictionary map for major companies using job boards
      final Map<String, String> popularDomains = {
        'ola': 'olaelectric.com',
        'razorpay': 'razorpay.com',
        'phonepe': 'phonepe.com',
        'google': 'google.com',
        'microsoft': 'microsoft.com',
        'amazon': 'amazon.com',
        'flipkart': 'flipkart.com',
      };

      if (popularDomains.containsKey(cleanCompany)) {
        return 'https://logo.clearbit.com/${popularDomains[cleanCompany]}';
      }

      // 2. Fallback logic for companies not in the popular map
      final host = Uri.parse(url).host.toLowerCase().replaceFirst('www.', '');
      if (host.isEmpty) return '';

      // If the link falls back to an application management portal or aggregator,
      // return empty string so your UI falls back nicely to Icons.business
      if (host.contains('google.com') ||
          host.contains('forms.gle') ||
          host.contains('greenhouse.io') ||
          host.contains('lever.co') ||
          host.contains('linkedin.com')) {
        return '';
      }

      return 'https://logo.clearbit.com/$host';
    } catch (_) {
      return '';
    }
  }
}
