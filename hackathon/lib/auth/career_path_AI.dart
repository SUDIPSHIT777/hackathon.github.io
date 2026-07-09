import 'dart:convert';
import 'dart:developer';
import 'package:hackathon/config/app_config.dart';
import 'package:hackathon/model/career_path_model.dart';
import 'package:http/http.dart' as http;

Future<CareerPathModel?> getCareerPathAI(String stream, String degree) async {
  String prompt =
      """
Stream: $stream
Degree: $degree

Return ONLY valid JSON.

{
  "match_score": 0,
  "match_label": "",

  "careers": [
    "",
    "",
    "",
    ""
  ],

  "roadmap": [
    "",
    "",
    "",
    ""
  ]
}

Rules:
- match_score between 0 and 100
- match_label should be one of:
  Excellent Match
  Good Match
  Average Match

- careers must contain exactly 4 career options

- roadmap must contain exactly 4 steps:
  Year 1 focus
  Year 2 focus
  Year 3 focus
  Year 4 focus

- JSON only
- No markdown
- No explanation
""";
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
            "content": "You are a strict JSON API. Return JSON only.",
          },
          {"role": "user", "content": prompt},
        ],
        "temperature": 0.2,
        "max_tokens": 500,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      var data = result["choices"][0]["message"]["content"];

      data = data.replaceAll("```json", "").replaceAll("```", "").trim();
      log("Career API Response: $data");
      return CareerPathModel.fromJson(jsonDecode(data));
    }
  } catch (e) {
    log("Stream AI Error: $e");
  }

  return null;
}
