import 'package:flutter/material.dart';
import 'package:hackathon/auth/career_path_ai.dart';
import 'package:hackathon/model/career_path_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CareerPathController extends ChangeNotifier {
  bool isLoading = false;

  CareerPathModel? data;

  Future<void> loadCareerPath(String stream, String degree) async {
    isLoading = true;
    notifyListeners();

    data = await getCareerPathAI(stream, degree);

    isLoading = false;
    notifyListeners();
  }

  static void lunch(String name) async {
    final url = Uri.parse(
      "https://www.google.com/search?q=${name}+job+role+details&sca_esv=9a17aeb5f0484a4c&sxsrf=APpeQnu_Od-ZhM8H6nA3kb44Jiqpn7u0ZQ%3A1783605701581&source=hp&ei=xalPap7_IKuhnesPl9Cy-Aw&iflsig=ABILxe8AAAAAak-31VrkMobdwbuI3j5ORIjYkt4Ot28W&oq=software&gs_lp=Egdnd3Mtd2l6Ighzb2Z0d2FyZSoCCAIyDRAAGIAEGIoFGEMYsQMyDRAAGIAEGIoFGEMYsQMyDRAAGIAEGIoFGEMYsQMyCBAAGIAEGLEDMg0QABiABBiKBRhDGLEDMg0QABiABBiKBRhDGLEDMg0QABiABBiKBRhDGLEDMg0QABiABBiKBRhDGLEDMgoQABiABBiKBRhDMgUQABiABEiMPlDjBFj4F3ABeACQAQCYAd4BoAGYDKoBBTAuNi4yuAEDyAEA-AEBmAIJoALqDKgCCsICBxAjGOoCGCfCAg0QIxjwBRjJAhjqAhgnwgIHEC4Y6gIYJ8ICBBAjGCfCAg4QABiABBiKBRixAxiDAcICERAuGIAEGLEDGIMBGMcBGNEDwgILEAAYgAQYsQMYgwHCAhEQABiABBiKBRiNBhixAxiDAcICChAjGMkCGPAFGCfCAhYQLhiABBiKBRhDGLEDGIMBGMcBGNEDwgIQEAAYgAQYigUYQxixAxiDAcICEBAuGEMYxwEY0QMYgAQYigXCAhAQLhiABBiKBRhDGMcBGNEDwgITEC4YgAQYigUYQxixAxjHARjRA8ICEBAuGIAEGIoFGEMYxwEYrwHCAg0QLhiABBiKBRhDGLEDmAMa8QUAKWw607YhJ5IHBTEuNS4zoAeWP7IHBTAuNS4zuAfQDMIHBzItOC4wLjHIBzqACAE&sclient=gws-wiz",
    );
    await launchUrl(url);
  }
}
