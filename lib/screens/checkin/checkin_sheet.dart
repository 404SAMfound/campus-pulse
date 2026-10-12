import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../../data/campus_data.dart';

/// Check-in — pick a real KIIT space first, then crowd level. No fake submit.
Future<void> showCheckinSheet(BuildContext context, {String? initialSpaceId}) {
  String? spaceId = initialSpaceId;
  int selected = -1;
  final tags = <String, bool>{
    'Outlets open': false,
    'AC is frosty': false,
    'Pure silence': false,
    'Rising noise': false,
  };
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          const options = ['Chill / Empty', 'Moderate / Okay', 'Slammed / Packed'];
          const descs = [
            'Seats everywhere, walk-in ease.',
            'Decent spots, moderate buzz.',
            'No free tables, long queues.',
          ];
          final space = spaceId == null
              ? null
              : CampusData.spaces.firstWhere((s) => s.id == spaceId);
          final canSubmit = space != null && selected != -1;
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(width: 44, height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.track, borderRadius: BorderRadius.circular(4))),
                  ),
                  const SizedBox(height: 12),
                  Text('${CampusData.campusName} • CHECK-IN', style: AppText.monoLabel(color: AppColors.terracotta)),
                  const SizedBox(height: 6),
                  Text("How's the crowd\nright now?", style: AppText.displayMedium(ctx)),
                  const SizedBox(height: 10),
                  Text('SPACE', style: AppText.monoLabel()),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final s in CampusData.spaces)
                        ChoiceChip(
                          label: Text(s.name, style: AppText.monoValue(
                            color: spaceId == s.id ? Colors.white : AppColors.ink)),
                          selected: spaceId == s.id,
                          selectedColor: AppColors.cocoa,
                          backgroundColor: AppColors.pastelFor(
                              CampusData.spaces.indexOf(s)),
                          showCheckmark: false,
                          onSelected: (_) => setState(() => spaceId = s.id),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  for (var i = 0; i < 3; i++)
                    Builder(builder: (ctx2) {
                      const bgs = [AppColors.greenBg, AppColors.butterBg, AppColors.roseBg];
                      return GestureDetector(
                      onTap: () => setState(() => selected = i),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: selected == i ? bgs[i] : AppColors.surface,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: selected == i ? AppColors.cocoa : AppColors.border,
                            width: selected == i ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(options[i],
                                    style: AppText.displaySmall(ctx).copyWith(fontSize: 17)),
                                  Text(descs[i], style: AppText.body(ctx)),
                                ],
                              ),
                            ),
                            Icon(
                              selected == i ? Icons.check_circle : Icons.circle_outlined,
                              color: selected == i ? AppColors.cocoa : AppColors.muted,
                            ),
                          ],
                        ),
                      ),
                    );
                    }),
                  const SizedBox(height: 6),
                  Text('Ambient Micro-tags', style: AppText.displaySmall(ctx).copyWith(fontSize: 15)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tags.keys.map((t) {
                      final on = tags[t]!;
                      return FilterChip(
                        label: Text(t, style: AppText.monoValue(
                          color: on ? AppColors.cocoa : AppColors.ink)),
                        selected: on,
                        showCheckmark: false,
                        selectedColor: AppColors.peachBg,
                        backgroundColor: AppColors.surface,
                        shape: StadiumBorder(side: BorderSide(
                          color: on ? AppColors.cocoa : AppColors.border)),
                        onSelected: (v) => setState(() => tags[t] = v),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: canSubmit ? AppColors.cocoa : AppColors.track,
                      foregroundColor: canSubmit ? Colors.white : AppColors.muted,
                      minimumSize: const Size(double.infinity, 54),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: canSubmit ? () => Navigator.pop(ctx) : null,
                    child: Text(space == null
                        ? 'Pick a space to continue'
                        : 'Submit for ${space.name}  •  +10 Pulse Points'),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text('UI only — stored locally until backend.',
                      style: AppText.monoLabel()),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
