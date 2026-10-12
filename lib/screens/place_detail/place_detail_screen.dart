import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../../widgets/graphs.dart';
import '../../data/campus_data.dart';

/// Place Detail — real KIIT spaces, floors for Central Library, no fake %.
class PlaceDetailScreen extends StatefulWidget {
  final String spaceId;
  final VoidCallback onCheckIn;
  final VoidCallback onBack;
  final ValueChanged<String> onSelectSpace;
  const PlaceDetailScreen({
    super.key,
    required this.spaceId,
    required this.onCheckIn,
    required this.onBack,
    required this.onSelectSpace,
  });

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final space = CampusData.spaces.firstWhere(
      (s) => s.id == widget.spaceId,
      orElse: () => CampusData.spaces.first,
    );
    final isLibrary = space.id == 'central-library';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: Text('Place Detail', style: AppText.displaySmall(context).copyWith(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final s in CampusData.spaces)
                    GestureDetector(
                      onTap: () => widget.onSelectSpace(s.id),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: s.id == space.id ? AppColors.ink : AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(s.name,
                          style: AppText.monoValue(
                            color: s.id == space.id ? Colors.white : AppColors.ink)),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.lilacBg,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${CampusData.campusName} • ${space.category.toUpperCase()}',
                    style: AppText.monoLabel(color: AppColors.lilacText)),
                  const SizedBox(height: 8),
                  Text(space.name, style: AppText.displayMedium(context).copyWith(color: AppColors.ink)),
                  Text(space.detail, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      _Stat(label: 'Noise', value: '—'),
                      SizedBox(width: 20),
                      _Stat(label: 'Outlets', value: '—'),
                      SizedBox(width: 20),
                      _Stat(label: 'Temp', value: '—'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Live readings appear here once backend is live.',
                    style: TextStyle(color: AppColors.muted,
                      fontFamily: 'Courier New', fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("TODAY'S CROWD CURVE", style: AppText.monoLabel()),
                  const SizedBox(height: 12),
                  const CrowdCurveSkeleton(),
                  const SizedBox(height: 8),
                  Text('Graph ready — values come from backend.',
                    style: AppText.body(context)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(isLibrary ? 'Floor Breakdown' : 'Zones', style: AppText.displaySmall(context)),
                const Spacer(),
                Text(isLibrary ? '3 floors • no data' : 'No sub-zones yet',
                  style: AppText.monoLabel()),
              ],
            ),
            const SizedBox(height: 8),
            if (isLibrary)
              for (var fi = 0; fi < CampusData.libraryFloors.length; fi++)
                Builder(builder: (context) {
                  final f = CampusData.libraryFloors[fi];
                  return Container(
                  margin: const EdgeInsets.only(bottom: 8),
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
                          color: AppColors.pastelFor(fi), borderRadius: BorderRadius.circular(12)),
                        child: Icon(Icons.layers_outlined,
                          color: fi % 3 == 0 ? AppColors.peachText : fi % 3 == 1 ? AppColors.lilacText : AppColors.sageText),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$f • Central Library',
                              style: AppText.displaySmall(context).copyWith(fontSize: 15)),
                            Text('Awaiting sensor', style: AppText.body(context)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.pastelFor(fi + 1), borderRadius: BorderRadius.circular(20)),
                        child: Text('—', style: AppText.monoLabel()),
                      ),
                    ],
                  ),
                );
                })
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text('Sub-areas for ${space.name} will list here.',
                  style: AppText.body(context)),
              ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.bg,
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.navy,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: const StadiumBorder(),
          ),
          onPressed: widget.onCheckIn,
          child: Text('I am at ${space.name} — Check In  +10 pts'),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(),
          style: const TextStyle(color: AppColors.muted, fontFamily: 'Courier New', fontSize: 10)),
        Text(value, style: const TextStyle(color: AppColors.ink, fontSize: 16)),
      ],
    );
  }
}
