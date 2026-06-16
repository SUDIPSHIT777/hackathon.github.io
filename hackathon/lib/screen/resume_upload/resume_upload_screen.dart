import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';
import 'package:resume_xpert/features/data/get_userData.dart';
import 'package:resume_xpert/features/presentation/screens/ResumeUploadScreen/controller/homeController.dart';

class ResumeUploadScreen extends StatefulWidget {
  const ResumeUploadScreen({super.key});

  @override
  State<ResumeUploadScreen> createState() => _ResumeUploadScreenState();
}

class _ResumeUploadScreenState extends State<ResumeUploadScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x2DAB8DFF),
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            // child: Icon(Icons.person),
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
        ),
        title: Text(
          'Resume Xpert',
          style: TextStyle(
            // fontSize: 20,
            fontWeight: FontWeight.w500,
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
            crossAxisAlignment: .center,
            children: [
              Text(
                'Analyze Your Resume',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: .center,
              ),
              Text(
                'Upload your resume to get AI-powered insights and transform your professional narrative.',
                style: TextStyle(fontSize: 15),
                textAlign: .center,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black12),
                ),
                child: Consumer<Homecontroller>(
                  builder: (context, controller, child) =>
                      controller.fileName != ""
                      ? pdfCard(fileName: controller.fileName)
                      : Column(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // animation card
                            SizedBox(
                              height: 200,
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Lottie.asset(
                                      'assets/animations/Search.json',
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Lottie.asset(
                                      width: 80,
                                      'assets/animations/Sparkles Loop Loader ai.json',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),

                            //----------------------- btn
                            GestureDetector(
                              onTap: () {
                                context.read<Homecontroller>().pickFile();
                              },
                              child: Container(
                                width: 200,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blueAccent,
                                      Colors.deepPurpleAccent,
                                    ],
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload_file,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Upload PDF',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            // ----bottom text
                            Column(
                              spacing: 5,
                              children: [
                                Text(
                                  'OR DRAG AND DROP FILE HERE',
                                  style: TextStyle(color: Colors.black54),
                                  textAlign: .center,
                                ),
                                Text(
                                  'Supported formats: PDF, DOCX (Max 5MB)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                  ),
                                  textAlign: .center,
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ),
              cards(
                Icons.psychology_outlined,
                'Skill Gap Analysis',
                "Identify what's missing to reach your dream role.",
              ),
              cards(
                Icons.document_scanner_outlined,
                'ATS Optimization',
                "Get past automated filters with ease.",
              ),
              cards(
                Icons.stacked_line_chart_outlined,
                'Impact Scoring',
                "Quantify your achievements effectively.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------pdf card
  Widget pdfCard({
    required String fileName,
    // required Function onCancel,
    // required Function onSubmit,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.blueAccent, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        spacing: 10,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              style: ListTileStyle.list,
              leading: Lottie.asset('assets/animations/pdf.json'),
              title: Text(
                fileName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(
            spacing: 10,
            children: [
              // ------------- cancle btn
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [Colors.pink, Colors.red]),
                  ),
                  child: ElevatedButton(
                    onPressed: () => Provider.of<Homecontroller>(
                      context,
                      listen: false,
                    ).onCancel(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                    ),
                    child: Text('Cancle'),
                  ),
                ),
              ),
              // ------------- submit btn
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.red],
                    ),
                  ),

                  child: ElevatedButton(
                    onPressed: () => Provider.of<Homecontroller>(
                      context,
                      listen: false,
                    ).onSubmit(context),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                    ),
                    child: Text('Scan'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ------- ui cards
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
}
