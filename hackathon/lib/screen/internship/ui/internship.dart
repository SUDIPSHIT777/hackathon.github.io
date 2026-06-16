import 'package:flutter/material.dart';
import 'package:hackathon/model/internshipmodel.dart';
import 'package:hackathon/screen/internship/controller/intershipcontroller.dart';

class InternshipDashboard extends StatefulWidget {
  const InternshipDashboard({super.key});

  @override
  State<InternshipDashboard> createState() => _InternshipDashboardState();
}

class _InternshipDashboardState extends State<InternshipDashboard> {
  final Future<List<InternshipModel>> internships =
      InternshipService.getInternships();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030914),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsiveness parameters
            double maxContentWidth = 720.0;
            double horizontalPadding = constraints.maxWidth > 600 ? 32.0 : 16.0;

            return Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  20.0,
                  horizontalPadding,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                    const SizedBox(height: 24),
                    _buildSectionHeader(),
                    const SizedBox(height: 12),
                    Expanded(
                      child: FutureBuilder<List<InternshipModel>>(
                        future: internships,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                snapshot.error.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }

                          final data = snapshot.data ?? [];

                          if (data.isEmpty) {
                            return const Center(
                              child: Row(
                                spacing: 10,
                                children: [
                                  Text("No Internship Found"),
                                  Icon(Icons.work),
                                ],
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final item = data[index];

                              return _buildInternshipCard(
                                logoPath: "",
                                role: item.role,
                                company: item.company,
                                location: item.location,
                                isHybrid: false,
                                isRemote: false,
                                tags: [item.duration],
                                stipend: item.stipend,
                                applyBy: "Open",
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // 1. Top Header Component
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
                children: [
                  TextSpan(
                    text: 'Internship ',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: 'Finder',
                    style: TextStyle(color: Color(0xFF00D2C4)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Find the best internships to kickstart your career',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Ongoing Internships',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // 4. Core Card Item using Image.asset
  Widget _buildInternshipCard({
    required String logoPath, // Renamed parameter to accept asset string path
    required String role,
    required String company,
    required String location,
    required bool isHybrid,
    required bool isRemote,
    required List<String> tags,
    required String stipend,
    required String applyBy,
    bool isZomato = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF091224),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 48,
                width: 48,
                padding: EdgeInsets.all(isZomato ? 0 : 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF162544),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isZomato ? 12 : 0),
                  child: logoPath.isEmpty
                      ? const Icon(Icons.business, color: Colors.grey)
                      : Image.asset(logoPath, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          company,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          color: Color(0xFF2F80ED),
                          size: 14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: Colors.white38,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          location,
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          isRemote
                              ? Icons.language_rounded
                              : Icons.computer_rounded,
                          size: 14,
                          color: Colors.white38,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isRemote
                              ? 'Remote'
                              : (isHybrid ? 'Hybrid' : 'On-site'),
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.bookmark_border_rounded,
                color: Colors.white70,
                size: 22,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: tags.map((tag) {
                    final bool isCounter = tag.startsWith('+');
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isCounter
                            ? Colors.transparent
                            : const Color(0xFF0D1B2A),
                        borderRadius: BorderRadius.circular(8),
                        border: isCounter
                            ? Border.all(
                                color: Colors.white.withValues(alpha: 0.08),
                              )
                            : null,
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: isCounter ? Colors.white38 : Colors.white70,
                          fontSize: 11,
                          fontWeight: isCounter
                              ? FontWeight.normal
                              : FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Stipend',
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stipend,
                    style: const TextStyle(
                      color: Color(0xFF00D2C4),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white38,
                      ),
                      children: [
                        const TextSpan(text: 'Apply by '),
                        TextSpan(
                          text: applyBy,
                          style: const TextStyle(
                            color: Color(0xFFA855F7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 5. Matches Bottom Banner
  Widget _buildMatchBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D1333), Color(0xFF05081A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.business_center_rounded,
              color: Color(0xFF2F80ED),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Personalized Internship Matches',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Answer a few questions and get internships tailored just for you.',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0074FF),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Get Started ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward_rounded, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
