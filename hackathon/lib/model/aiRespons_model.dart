class AiresponsModel {
  final String name;
  final String role;
  final int score;
  final String summary;
  final List<String> missingSkills;
  final String aiRecommendation;
  final String marketMatch;
  final List<CardModel> keyStrengths;
  final List<CardModel> criticalGaps;
  final List<String> optimizationSteps;
  final DateTime createdAt;

  AiresponsModel({
    required this.name,
    required this.role,
    required this.score,
    required this.summary,
    required this.missingSkills,
    required this.aiRecommendation,
    required this.marketMatch,
    required this.keyStrengths,
    required this.criticalGaps,
    required this.optimizationSteps,
    required this.createdAt,
  });

  factory AiresponsModel.fromJson(Map<String, dynamic> json) {
    return AiresponsModel(
      name: json["name"] ?? "",
      role: json["role"] ?? "",
      score: json["score"] ?? 0,
      summary: json["summary"] ?? "",
      missingSkills: List<String>.from(json["missing_skills"] ?? []),
      aiRecommendation: json["ai_recommendation"] ?? "",
      marketMatch: json["market_match"] ?? "",
      keyStrengths: (json["key_strengths"] as List? ?? [])
          .map((e) => CardModel.fromJson(e))
          .toList(),
      criticalGaps: (json["critical_gaps"] as List? ?? [])
          .map((e) => CardModel.fromJson(e))
          .toList(),
      optimizationSteps: List<String>.from(json["optimization_steps"] ?? []),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        json["created_at"] ?? DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "role": role,
      "score": score,
      "summary": summary,
      "missing_skills": missingSkills,
      "ai_recommendation": aiRecommendation,
      "market_match": marketMatch,
      "key_strengths": keyStrengths.map((e) => e.toJson()).toList(),
      "critical_gaps": criticalGaps.map((e) => e.toJson()).toList(),
      "optimization_steps": optimizationSteps,
      "created_at": createdAt.millisecondsSinceEpoch,
    };
  }
}

class CardModel {
  final String title;
  final String description;

  CardModel({required this.title, required this.description});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      title: json["title"] ?? "",
      description: json["description"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "description": description};
  }
}
