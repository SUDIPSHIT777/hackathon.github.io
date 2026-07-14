import 'dart:async';
import 'dart:convert';
import 'package:hackathon/config/app_config.dart';
import 'package:hackathon/model/internshipmodel.dart';
import 'package:http/http.dart' as http;

class InternshipService {
  static final Map<String, List<InternshipModel>> _cache = {};

  static Future<List<InternshipModel>> getInternships({String? role}) async {
    final cacheKey = (role ?? '').trim().toLowerCase();

    // Avoid re-hitting the model for a query we already have.
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    try {
      final response = await http.post(
        Uri.parse(AppConfig.api),
        headers: {
          'Authorization': 'Bearer ${AppConfig.apikey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "deepseek/deepseek-chat",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are a JSON API. Return ONLY a valid JSON array. No markdown, no commentary, no trailing text.",
            },
            {"role": "user", "content": _buildPrompt(role)},
          ],
          "temperature": 0.3,
          "max_tokens": 4000,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception("API Error ${response.statusCode}");
      }

      final result = jsonDecode(response.body);
      String content = result["choices"][0]["message"]["content"] as String;
      content = content.replaceAll("```json", "").replaceAll("```", "").trim();

      final match = RegExp(r'\[[\s\S]*\]').firstMatch(content);
      if (match == null) {
        throw Exception("No JSON array found in response");
      }

      final List<dynamic> data = jsonDecode(match.group(0)!);
      final internships = data
          .whereType<Map<String, dynamic>>()
          .map((e) => InternshipModel.fromJson(e))
          .where((i) => i.applyUrl.isNotEmpty)
          .toList();

      _cache[cacheKey] = internships;
      return internships;
    } catch (e) {
      rethrow;
    }
  }

  static String _buildPrompt(String? role) {
    final target = (role == null || role.trim().isEmpty)
        ? "Software Engineering Intern"
        : role.trim();

    return """
Generate 15 real, currently-open internships in India for: $target.
Rules:
- Use real, well-known companies only.
- applyUrl must be the company's actual internship/careers page.
- workMode must be exactly one of: Remote, Hybrid, On-site.
- Return ONLY raw JSON in this exact shape, nothing else:

[
  {
    "company": "Google",
    "role": "$target",
    "location": "Bangalore",
    "duration": "6 Months",
    "stipend": "₹50000/month",
    "workMode": "On-site",
    "applyUrl": "https://careers.google.com"
  }
]
""";
  }

  static void clearCache() => _cache.clear();
}
