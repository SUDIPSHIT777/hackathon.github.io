class CareerPathModel {
  final int matchScore;
  final String matchLabel;

  final List<String> careers;

  final List<String> roadmap;

  CareerPathModel({
    required this.matchScore,
    required this.matchLabel,
    required this.careers,
    required this.roadmap,
  });

  factory CareerPathModel.fromJson(Map<String, dynamic> json) {
    return CareerPathModel(
      matchScore: (json['match_score'] as num?)?.toInt() ?? 0,

      matchLabel: json['match_label']?.toString() ?? '',

      careers: List<String>.from(json['careers'] ?? []),

      roadmap: List<String>.from(json['roadmap'] ?? []),
    );
  }
}
