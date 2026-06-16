class InternshipModel {
  final String company;
  final String role;
  final String location;
  final String duration;
  final String stipend;

  InternshipModel({
    required this.company,
    required this.role,
    required this.location,
    required this.duration,
    required this.stipend,
  });

  factory InternshipModel.fromJson(Map<String, dynamic> json) {
    return InternshipModel(
      company: json["company"] ?? "",
      role: json["role"] ?? "",
      location: json["location"] ?? "",
      duration: json["duration"] ?? "",
      stipend: json["stipend"] ?? "",
    );
  }
}
