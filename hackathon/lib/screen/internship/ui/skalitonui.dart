import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InternshipSkeletonCard extends StatelessWidget {
  const InternshipSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF091224),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 16, width: 180, color: Colors.white),
                  const SizedBox(height: 10),
                  Container(height: 14, width: 120, color: Colors.white),
                  const SizedBox(height: 10),
                  Container(height: 12, width: 200, color: Colors.white),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(width: 70, height: 24, color: Colors.white),
                      const SizedBox(width: 8),
                      Container(width: 60, height: 24, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
