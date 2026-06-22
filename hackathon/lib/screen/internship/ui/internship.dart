import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/model/internshipmodel.dart';
import 'package:hackathon/screen/internship/controller/intershipcontroller.dart';
import 'package:url_launcher/url_launcher.dart';

class InternshipDashboard extends StatefulWidget {
  const InternshipDashboard({super.key});

  @override
  State<InternshipDashboard> createState() => _InternshipDashboardState();
}

class _InternshipDashboardState extends State<InternshipDashboard> {
  Future<List<InternshipModel>>? internships;
  final TextEditingController searchController = TextEditingController();

  Future<void> openInternship(String url) async {
    final uri = Uri.parse(url);
    final success = await launchUrl(uri, mode: LaunchMode.externalApplication);
    debugPrint("LAUNCH RESULT => $success");
  }

  @override
  void initState() {
    super.initState();
    internships = InternshipService.getInternships();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030914),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "INTERNSHIP FINDER",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          InternshipService.clearCache();
          setState(() {
            internships = InternshipService.getInternships(
              role: searchController.text,
            );
          });
          await internships;
        },
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No Internship Found",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.work, color: Colors.white70),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final item = data[index];
                              final mode = item.workMode.toLowerCase();
                              return _buildInternshipCard(
                                key: ValueKey(item.applyUrl + item.role),
                                logoUrl: item.icon,
                                role: item.role,
                                company: item.company,
                                location: item.location,
                                isHybrid: mode == 'hybrid',
                                isRemote: mode == 'remote',
                                tags: [item.duration],
                                stipend: item.stipend,
                                applyBy: "Open",
                                applyUrl: item.applyUrl,
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
    return Column(
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
        const SizedBox(height: 8),
        Text(
          'Find the best internships to kickstart your career',
          style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
        ),
        const SizedBox(height: 18),
        // Search Bar
        Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF091224),
            borderRadius: BorderRadius.circular(14),
          ),
          child: TextField(
            controller: searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search role...",
              hintStyle: TextStyle(color: Colors.grey.shade500),
              prefixIcon: const Icon(Icons.search, color: Colors.white54),
            ),
            onSubmitted: (value) {
              setState(() {
                internships = InternshipService.getInternships(role: value);
              });
            },
          ),
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

  // 4. Core Card Item
  Widget _buildInternshipCard({
    Key? key,
    required String logoUrl,
    required String role,
    required String company,
    required String location,
    required bool isHybrid,
    required bool isRemote,
    required List<String> tags,
    required String stipend,
    required String applyBy,
    required String applyUrl,
  }) {
    return GestureDetector(
      key: key,
      onTap: () => openInternship(applyUrl),
      child: Container(
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
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF162544),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: logoUrl.isEmpty
                        ? const Icon(Icons.business, color: Colors.grey)
                        : Image.network(
                            logoUrl,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stack) =>
                                const Icon(Icons.business, color: Colors.grey),
                          ),
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
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
