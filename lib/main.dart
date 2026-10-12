import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/live_map/live_map_screen.dart';
import 'screens/place_detail/place_detail_screen.dart';
import 'screens/checkin/checkin_sheet.dart';
import 'widgets/bottom_nav.dart';

void main() => runApp(const CampusPulseApp());

class CampusPulseApp extends StatelessWidget {
  const CampusPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Pulse',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const _Root(),
    );
  }
}

class _Root extends StatefulWidget {
  const _Root();

  @override
  State<_Root> createState() => _RootState();
}

class _RootState extends State<_Root> {
  bool onboarded = false;
  int tab = 0;
  String spaceId = 'central-library';
  final List<int> _history = [0];

  void _goTab(int i) {
    if (i == tab) return;
    setState(() {
      tab = i;
      _history.add(i);
    });
  }

  void _openSpace(String id) {
    setState(() => spaceId = id);
    _goTab(2);
  }

  /// Returns true if back was handled (went to previous screen).
  bool _handleBack() {
    if (!onboarded) return false;
    if (_history.length > 1) {
      setState(() {
        _history.removeLast();
        tab = _history.last;
      });
      return true;
    }
    if (tab != 0) {
      setState(() {
        tab = 0;
        _history.add(0);
      });
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (!onboarded) {
      return OnboardingScreen(onNext: () => setState(() => onboarded = true));
    }
    final canClose = _history.length <= 1 && tab == 0;
    return PopScope(
      canPop: canClose,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _handleBack();
      },
      child: Scaffold(
        body: IndexedStack(
          index: tab,
          children: [
            HomeScreen(
              onOpenMap: () => _goTab(1),
              onOpenSpace: _openSpace,
            ),
            LiveMapScreen(onOpenSpace: _openSpace),
            PlaceDetailScreen(
              spaceId: spaceId,
              onSelectSpace: (id) => setState(() => spaceId = id),
              onBack: _handleBack,
              onCheckIn: () => showCheckinSheet(context, initialSpaceId: spaceId),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNav(
          active: tab,
          onTap: (i) {
            if (i == 3) {
              showCheckinSheet(context, initialSpaceId: spaceId);
              return;
            }
            _goTab(i.clamp(0, 2));
          },
        ),
        extendBody: true,
      ),
    );
  }
}
