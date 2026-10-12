import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../../data/campus_data.dart';

/// Live Map — KIIT canvas with 6 real pins (names only, no fake %).
class LiveMapScreen extends StatelessWidget {
  final ValueChanged<String> onOpenSpace;
  const LiveMapScreen({super.key, required this.onOpenSpace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.radar, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Text('campus pulse', style: AppText.displaySmall(context).copyWith(fontSize: 18)),
                  const Spacer(),
                  Text(CampusData.campusName, style: AppText.monoLabel()),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _chip('All spots', true),
                  _chip('Study', false),
                  _chip('Food', false),
                  _chip('Outdoor', false),
                  _chip('Fitness', false),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text('● Inside ${CampusData.campusName} • 6 spaces',
                  style: AppText.monoLabel()),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.peachBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    for (var pi = 0; pi < CampusData.spaces.length; pi++)
                      Builder(builder: (context) {
                        final s = CampusData.spaces[pi];
                        final dot = pi % 4 == 0
                            ? AppColors.peachText
                            : pi % 4 == 1
                                ? AppColors.lilacText
                                : pi % 4 == 2
                                    ? AppColors.sageText
                                    : AppColors.butterText;
                        return GestureDetector(
                        onTap: () => onOpenSpace(s.id),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(s.icon, size: 16, color: dot),
                              const SizedBox(width: 6),
                              Text(s.name, style: AppText.monoValue()),
                            ],
                          ),
                        ),
                      );
                      }),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('6 SPACES • 0 LIVE', style: AppText.monoLabel(color: AppColors.terracotta)),
                  const SizedBox(height: 6),
                  Text('Tap a space for details', style: AppText.displaySmall(context)),
                  Text('Live counts appear here once backend reports.',
                    style: AppText.body(context)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.track,
                            foregroundColor: AppColors.muted,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: null,
                          child: const Text('Navigate (—)'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.navy,
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () => onOpenSpace('central-library'),
                          child: const Text('View Details →'),
                        ),
                      ),
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

  Widget _chip(String label, bool active) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: active ? AppColors.ink : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(label,
        style: AppText.monoValue(color: active ? Colors.white : AppColors.ink)),
    );
  }
}
