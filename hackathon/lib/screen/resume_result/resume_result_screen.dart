import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/screen/resume_result/controller/resume_result_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
class ResultScreen extends StatefulWidget {
  final String page;
  const ResultScreen({super.key, required this.page});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ResumeResultController>(
      builder: (context, controller, child) => Scaffold(
        backgroundColor: Color.fromARGB(255, 242, 247, 251),
        // backgroundColor: Color(0xffF4F6FA),
        appBar: AppBar(
          leading: IconButton(
            // --------------------------- need to modify
            onPressed: () {
              // widget.page == "home" ? context.go("/home") : context.pop()
              }, icon: ,;
                
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Colors.white,
          // backgroundColor: const Color.fromARGB(46, 171, 141, 255),
          surfaceTintColor: Colors.transparent,
          titleSpacing: 0,
          centerTitle: true,
          title: Text(
            'Resume Result',
            style: TextStyle(
              // fontSize: 20,
              fontWeight: FontWeight.bold,
              // color: Colors.blueAccent
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentGeometry.bottomCenter,
                colors: [
                  const Color.fromARGB(96, 146, 186, 255),
                  const Color.fromARGB(46, 171, 141, 255),
                ],
              ),
            ),
            child: Column(
              spacing: 10,
              children: [
                // ------------ score card
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // Text(
                      //   controller.respons.createdAt.toString(),
                      //   style: TextStyle(
                      //     // fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //     // color: Colors.blueAccent
                      //   ),
                      // ),
                      // ------------ name
                      Text(
                        controller.respons.name,
                        style: GoogleFonts.crimsonText(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(height: 10),
                      // ------------------------ progress indicator
                      CircularPercentIndicator(
                        animation: true,
                        animationDuration: 1200,
                        radius: 70.0,
                        lineWidth: 10.0,
                        circularStrokeCap: CircularStrokeCap.round,
                        // backgroundColor: Colors.grey,
                        percent: controller.respons.score / 100,
                        center: Text(
                          controller.respons.score.toString(),
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),

                        progressColor: color(controller.respons.score),
                        // linearGradient: LinearGradient(
                        //   colors: [
                        //     Colors.lightBlueAccent,
                        //     Colors.blueAccent,
                        //     Colors.lightBlue,
                        //     Colors.blue,
                        //   ],
                        // ),
                      ),
                      // SizedBox(height: 20),
                      Text(
                        'Resume Score',
                        style: GoogleFonts.crimsonText(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(controller.respons.summary, textAlign: .center),
                    ],
                  ),
                ),
                // ------------ Missing Skills card
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(0xffF2F4F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    spacing: 20,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(CupertinoIcons.sparkles, color: Colors.amber),
                          Text(
                            'MISSING SKILLS',
                            style: TextStyle(letterSpacing: 2),
                          ),
                        ],
                      ),

                      Wrap(
                        spacing: 5,
                        runSpacing: 10,
                        children: [
                          ...missingSkills(controller.respons.missingSkills),
                        ],
                      ),

                      // GestureDetector(
                      //   // onTap: () => callAI(),
                      //   // onTap: () => AiFeature.generateText("hello"),
                      //   child: Container(
                      //     width: 200,
                      //     padding: EdgeInsets.symmetric(
                      //       horizontal: 5,
                      //       vertical: 10,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //       gradient: LinearGradient(
                      //         colors: [
                      //           Colors.blueAccent,
                      //           Colors.deepPurpleAccent,
                      //         ],
                      //       ),
                      //     ),
                      //     child: Center(
                      //       child: Text(
                      //         'Improve Resume',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                cards(
                  Icons.psychology,
                  'AI Recommendation',
                  controller.respons.aiRecommendation,
                ),
                cards(
                  Icons.stacked_line_chart_outlined,
                  'Market Match',
                  controller.respons.marketMatch,
                ),
                SizedBox(
                  child: Column(
                    spacing: 8,
                    children: [
                      titleCard(
                        Colors.blueAccent,
                        'Key Strengths',
                        'Where your professional narrative shines brightest.',
                      ),
                      ...contentList(
                        controller.respons.keyStrengths,
                        const Color(0xFF1972BA),
                        Icons.done_all_sharp,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    spacing: 8,
                    children: [
                      titleCard(
                        Colors.red,
                        'Critical Gaps',
                        'Prioritize these fixes to increase interview callback rates.',
                      ),
                      ...contentList(
                        controller.respons.criticalGaps,
                        const Color(0xFFC03127),
                        Icons.info,
                      ),
                    ],
                  ),
                ),

                // ------------------------optimization
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Step-by-Step Optimization',
                      style: GoogleFonts.crimsonText(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        // decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(
                  // decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    spacing: 10,
                    children: [
                      // titleCard(
                      //   Colors.green,
                      //   'Optimizatin Steps',
                      //   'Prioritize these fixes to increase interview callback rates.',
                      // ),
                      ...optimizationList(controller.respons.optimizationSteps),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Every improvement here brings you closer to your dream job."
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    // fontSize: 15,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ----skill card
  Widget skillCard(String skill) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: Colors.white),
      child: Text(skill),
    );
  }

  // -------- build cards
  Widget cards(IconData ico, String title, String subTitle) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(ico, color: Colors.blueAccent),
          ),
          Text(
            title,
            style: TextStyle(color: Colors.black, fontWeight: .bold),
          ),
          Text(subTitle, style: TextStyle(fontSize: 12, color: Colors.black)),
        ],
      ),
    );
  }

  // ------- title card
  Widget titleCard(Color color, String title, String subTitle) {
    return Container(
      width: 500,
      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: Colors.white54),

      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 5,
            height: 100,
            decoration: BoxDecoration(color: color),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: .bold, fontSize: 20)),
                Text(subTitle, style: TextStyle(), maxLines: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------- content card
  Widget content(Color color, IconData ico, String title, String subTitle) {
    return Container(
      // width: 500,
      // margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withAlpha(50),
            child: Icon(ico, color: color),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: .bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(color: Colors.black45, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- optimization Card
  Widget optimizationCard(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        // color: const Color(0xFFF0F2F5),
        gradient: LinearGradient(
          colors: [Colors.green.withAlpha(40), Colors.lightGreen.withAlpha(60)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.green.withAlpha(40),
            child: Icon(
              Icons.keyboard_double_arrow_right_rounded,
              color: Colors.green,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontWeight: .bold),
              // maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  // -------------- missingSkills
  List<Widget> missingSkills(List data) {
    List<Widget> list = [SizedBox.shrink()];
    for (int i = 0; i < data.length; i++) {
      list.add(skillCard(data[i]));
    }
    return list;
  }

  // -------------- Dynamic content strength/gaps
  List<Widget> contentList(List<CardModel> data, Color color, IconData ico) {
    List<Widget> list = [SizedBox.shrink()];
    for (int i = 0; i < data.length; i++) {
      list.add(content(color, ico, data[i].title, data[i].description));
    }
    return list;
  }

  // -------------- Dynamic content strength/gaps
  List<Widget> optimizationList(List data) {
    List<Widget> list = [SizedBox.shrink()];
    for (int i = 0; i < data.length; i++) {
      list.add(optimizationCard(data[i]));
    }
    return list;
  }

  // ---------- color fun
  Color color(int number) {
    if (number < 50)
      return Colors.red;
    else if (number < 80)
      return Colors.orange;
    else
      return Colors.green;
  }
}
