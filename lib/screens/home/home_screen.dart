import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../../widgets/graphs.dart';
import '../../data/campus_data.dart';

/// Home — hey SAM, KIIT, 6 real spaces, no fake occupancy.
class HomeScreen extends StatelessWidget {
  final VoidCallback onOpenMap;
  final ValueChanged<String> onOpenSpace;
  const HomeScreen({super.key, required this.onOpenMap, required this.onOpenSpace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.radar, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Text('campus pulse', style: AppText.displaySmall(context).copyWith(fontSize: 18)),
                  const Spacer(),
                  const CircleAvatar(
                    radius: 16, backgroundColor: AppColors.navy,
                    child: Icon(Icons.person_outline, color: Colors.white, size: 18),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('OVERVIEW  •  ${CampusData.campusName} CAMPUS', style: AppText.monoLabel()),
              const SizedBox(height: 4),
              Text('hey ${CampusData.userName},', style: AppText.displayMedium(context)),
              Text('6 spaces connected — waiting for first live signal.',
                style: AppText.body(context)),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.peachBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BEST TIME TO GO', style: AppText.monoLabel(color: AppColors.peachText)),
                    const SizedBox(height: 8),
                    Text('No live data yet', style: AppText.displaySmall(context)),
                    Text('Once sensors report, quietest hour shows here.',
                      style: AppText.body(context)),
                    const SizedBox(height: 12),
                    const SparklinePlaceholder(caption: '6 SPACES • 0 LIVE —'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text('●  live now', style: AppText.displaySmall(context).copyWith(fontSize: 16)),
                  const Spacer(),
                  Text('awaiting signal', style: AppText.monoLabel()),
                ],
              ),
              const SizedBox(height: 10),
              for (var si = 0; si < CampusData.spaces.length; si++)
                Builder(builder: (context) {
                  final s = CampusData.spaces[si];
                  final iconBg = AppColors.pastelFor(si);
                  final iconColor = si % 4 == 0
                      ? AppColors.peachText
                      : si % 4 == 1
                          ? AppColors.lilacText
                          : si % 4 == 2
                              ? AppColors.sageText
                              : AppColors.butterText;
                  return GestureDetector(
                  onTap: () => onOpenSpace(s.id),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 42, height: 42,
                          decoration: BoxDecoration(
                            color: iconBg, borderRadius: BorderRadius.circular(12)),
                          child: Icon(s.icon, color: iconColor),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s.name, style: AppText.displaySmall(context).copyWith(fontSize: 16)),
                              Text('${s.category} • ${s.detail}', style: AppText.body(context)),
                              const SizedBox(height: 6),
                              Container(
                                height: 5,
                                decoration: BoxDecoration(
                                  color: AppColors.track, borderRadius: BorderRadius.circular(4)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.pastelFor(si + 2), borderRadius: BorderRadius.circular(20)),
                          child: Text('— NO DATA', style: AppText.monoLabel()),
                        ),
                      ],
                    ),
                  ),
                );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
