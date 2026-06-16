import 'dart:developer';


import 'package:hackathon/config/app_config.dart';
import 'package:hackathon/model/aiRespons_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AiFeature {
  // ------------ Openrouter
  static Future<AiresponsModel?> openRouterAI(
    String resumeText,
    // BuildContext context,
  ) async {
    String prompt =
        """
Analyze this resume as an ATS recruiter and career coach.

Return ONLY valid JSON in this exact format:

{
  "name": "",
  "role": "",
  "score": 0,
  "summary": "",
  "missing_skills": [],
  "ai_recommendation": "",
  "market_match": "",
  "key_strengths": [
    {
      "title": "",
      "description": ""
    }
  ],
  "critical_gaps": [
    {
      "title": "",
      "description": ""
    }
  ],
  "optimization_steps": []
}

Rules:
- Extract full candidate name
- role = best matching current job title
- score between 0 and 100
- summary max 25 words
- missing_skills max 3 or 4 items
- key_strengths max 2 or 3 items
- critical_gaps max 2 or 3 items
- optimization_steps max 5 items
- Each description max 12 words
- No markdown
- No explanation
- Return JSON only

Resume:
$resumeText
""";
    try {
      final response = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
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
                  "You are a strict JSON API. Never return text outside JSON.",
            },
            {"role": "user", "content": prompt},
          ],
          "max_tokens": 500,
          "temperature": 0.3,
        }),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        // log(name: "result", result.toString());
        var finalData = result["choices"][0]["message"]["content"];
        finalData = finalData
            .replaceAll("```json", "")
            .replaceAll("```", "")
            .trim();
        log(name: "finalData", finalData.toString());
        final json = jsonDecode(finalData);
        // json["created_at"] = DateTime.now().toIso8601String();
        json["created_at"] = DateTime.now().millisecondsSinceEpoch;
        return AiresponsModel.fromJson(json);
      } else {
        log("Something wemt wrong please try again");
      }
    } catch (e) {
      log(name: "api err", e.toString());
    }
    // log(AppConfig.openRouterkey);
    return null;
    // log(response.body);
  }
}
