import 'package:flutter/material.dart';

class UploadResumeScreen extends StatelessWidget {
  const UploadResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Exact color codes extracted from image_3f2fba.jpg
    const Color bgColor = Color(0xFF030A16);
    const Color cardBgColor = Color(0xFF071324);
    const Color textWhite = Colors.white;
    const Color textMuted = Color(0xFF6B7A90);
    const Color accentCyan = Color(0xFF00E5FF);
    const Color borderDashedColor = Color(0xFF132D4A);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Adjust layouts adaptively for wide screens (tablets / web)
            final bool isWideScreen = constraints.maxWidth > 700;
            final double horizontalPadding = isWideScreen ? 48.0 : 20.0;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 24.0,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 800,
                  ), // Perfect desktop restriction
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // --- TOP HEADER NAVIGATION BAR ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCircularNavButton(
                            Icons.arrow_back,
                            cardBgColor,
                            textWhite,
                          ),
                          _buildCircularNavButton(
                            Icons.close,
                            cardBgColor,
                            textWhite,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // --- HEADER TITLE SECTION ---
                      Center(
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                accentCyan.withOpacity(0.25),
                                Colors.transparent,
                              ],
                            ),
                            border: Border.all(
                              color: accentCyan.withOpacity(0.4),
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.upload_file_outlined,
                            color: accentCyan,
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'sans-serif',
                            ),
                            children: [
                              TextSpan(
                                text: 'Upload Your ',
                                style: TextStyle(color: textWhite),
                              ),
                              TextSpan(
                                text: 'Resume',
                                style: TextStyle(color: accentCyan),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Upload your resume to get personalized career recommendations\nbased on your skills and experience.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textMuted,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // --- DRAG & DROP DASHED AREA ---
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 36,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: cardBgColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: borderDashedColor,
                            width: 1.5,
                            style: BorderStyle.solid,
                          ), // Clean substitution for dashed border
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.cloud_upload_outlined,
                              color: accentCyan,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Drag & drop your resume here',
                              style: TextStyle(
                                color: textWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'or',
                                style: TextStyle(
                                  color: textMuted,
                                  fontSize: 14,
                                ),
                              ),
                            ),

                            // Choose File Button with dynamic gradient
                            Container(
                              height: 46,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF00D2FF),
                                    Color(0xFF4A00E0),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.file_upload_outlined,
                                  color: textWhite,
                                  size: 18,
                                ),
                                label: const Text(
                                  'Choose File',
                                  style: TextStyle(
                                    color: textWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Supports PDF, DOC, DOCX • Max size 5MB',
                              style: TextStyle(color: textMuted, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // --- TIPS FOR BEST RESULTS ---
                      const Text(
                        'Tips for best results',
                        style: TextStyle(
                          color: textWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Using a layout rule to turn 3 horizontal rows into single items on mobile
                      isWideScreen
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildTipCard(
                                    Icons.badge_outlined,
                                    'Use Updated Resume',
                                    'Make sure your resume is up to date for better recommendations.',
                                    const Color(0xFF6A1B9A),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildTipCard(
                                    Icons.list_alt_rounded,
                                    'Include Key Details',
                                    'Ensure your skills, projects, experience, and education are clearly mentioned.',
                                    const Color(0xFF1565C0),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildTipCard(
                                    Icons.track_changes_outlined,
                                    'Highlight Achievements',
                                    'Showcase your achievements to stand out better.',
                                    const Color(0xFF2E7D32),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildTipCard(
                                  Icons.badge_outlined,
                                  'Use Updated Resume',
                                  'Make sure your resume is up to date for better recommendations.',
                                  const Color(0xFF6A1B9A),
                                ),
                                const SizedBox(height: 12),
                                _buildTipCard(
                                  Icons.list_alt_rounded,
                                  'Include Key Details',
                                  'Ensure your skills, projects, experience, and education are clearly mentioned.',
                                  const Color(0xFF1565C0),
                                ),
                                const SizedBox(height: 12),
                                _buildTipCard(
                                  Icons.track_changes_outlined,
                                  'Highlight Achievements',
                                  'Showcase your achievements to stand out better.',
                                  const Color(0xFF2E7D32),
                                ),
                              ],
                            ),
                      const SizedBox(height: 24),

                      // --- DATA PRIVACY INFO SECTION ---
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardBgColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0A2240),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.shield_outlined,
                                color: Color(0xFF00E5FF),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your data is safe with us',
                                    style: TextStyle(
                                      color: textWhite,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'We never share your resume with anyone. Your information is secure and used only to provide better career recommendations.',
                                    style: TextStyle(
                                      color: textMuted,
                                      fontSize: 12,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.lock_outline,
                              color: textMuted,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),

                      // --- THIRD-PARTY IMPORTS DIVIDER ---
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              color: Color(0xFF12253D),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Or import from',
                              style: TextStyle(color: textMuted, fontSize: 13),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Color(0xFF12253D),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Responsive Third-Party Row Flex
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildImportPlatformButton(
                            'LinkedIn',
                            Icons.link,
                            isWideScreen,
                          ),
                          _buildImportPlatformButton(
                            'Google Drive',
                            Icons.add_to_drive,
                            isWideScreen,
                          ),
                          _buildImportPlatformButton(
                            'Dropbox',
                            Icons.cloud_outlined,
                            isWideScreen,
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),

                      // --- PRIVACY DECAL FOOTER ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.lock_reset_outlined,
                            color: textMuted,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Your information is ',
                            style: TextStyle(color: textMuted, fontSize: 12),
                          ),
                          Text(
                            '100% secure ',
                            style: TextStyle(
                              color: accentCyan,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'and private',
                            style: TextStyle(color: textMuted, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Circular functional Action bar item builder
  Widget _buildCircularNavButton(IconData icon, Color bg, Color itemColor) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bg,
        border: Border.all(color: const Color(0xFF1A2F4C)),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, color: itemColor, size: 18),
        onPressed: () {},
      ),
    );
  }

  // Reusable card building logic for standard tip components
  Widget _buildTipCard(
    IconData icon,
    String title,
    String description,
    Color iconAccentBg,
  ) {
    return Container(
      // height: 125,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF071324),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF10243D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconAccentBg.withOpacity(0.8), size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF6B7A90),
              fontSize: 12,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // Custom Integration Button generator matching bottom design variants
  Widget _buildImportPlatformButton(
    String label,
    IconData icon,
    bool isWideScreen,
  ) {
    return Container(
      width: isWideScreen ? 230 : double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF071324),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF10243D)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blueAccent, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}