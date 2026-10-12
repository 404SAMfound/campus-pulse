import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../../widgets/radar_sweep.dart';

/// Screen 1 — Onboarding 01/03. No fake stats, generic copy only.
class OnboardingScreen extends StatelessWidget {
  final VoidCallback onNext;
  const OnboardingScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  24,
            ),
            child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back, size: 18),
                  const SizedBox(width: 8),
                  Text('ONBOARDING', style: AppText.monoLabel()),
                  const Spacer(),
                  Text('Step 01 / 03', style: AppText.monoLabel()),
                ],
              ),
              const SizedBox(height: 24),
              const Center(child: RadarSweep(size: 240)),
              const SizedBox(height: 24),
              Text('●  CAMPUS PULSE RADAR', style: AppText.monoLabel(color: AppColors.terracotta)),
              const SizedBox(height: 8),
              Text('Stop guessing.\nStart knowing.', style: AppText.displayLarge(context)),
              const SizedBox(height: 12),
              Text(
                'Live crowd signals for your own campus. Connect your spaces to see them here.',
                style: AppText.body(context),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  'No spaces connected yet.\nAdd your campus in the next step.',
                  style: AppText.monoValue(color: AppColors.muted),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(width: 22, height: 6,
                    decoration: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(4))),
                  const SizedBox(width: 6),
                  Container(width: 6, height: 6,
                    decoration: const BoxDecoration(color: AppColors.track, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Container(width: 6, height: 6,
                    decoration: const BoxDecoration(color: AppColors.track, shape: BoxShape.circle)),
                  const Spacer(),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.cocoa,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: onNext,
                    child: const Text('Next  →'),
                  ),
                ],
              ),
              ],
            ),
            ),
          ),
          ),
        ),
      ),
    );
  }
}
