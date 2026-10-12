import 'package:flutter/material.dart';

/// Real KIIT campus data. No occupancy — live values come from backend later.
class CampusSpace {
  final String id;
  final String name;
  final String category; // Study | Food | Outdoor | Fitness
  final String detail;
  final IconData icon;
  const CampusSpace({
    required this.id,
    required this.name,
    required this.category,
    required this.detail,
    required this.icon,
  });
}

class CampusData {
  static const campusName = 'KIIT';
  static const userName = 'SAM';

  static const spaces = [
    CampusSpace(
      id: 'central-library',
      name: 'Central Library',
      category: 'Study',
      detail: '3 floors • silent zones',
      icon: Icons.local_library_outlined,
    ),
    CampusSpace(
      id: 'food-court',
      name: 'Food Court',
      category: 'Food',
      detail: 'Meals • rush hours vary',
      icon: Icons.restaurant_outlined,
    ),
    CampusSpace(
      id: 'library-garden',
      name: 'Library Garden',
      category: 'Outdoor',
      detail: 'Open-air • group friendly',
      icon: Icons.park_outlined,
    ),
    CampusSpace(
      id: 'mba-garden',
      name: 'MBA Garden',
      category: 'Outdoor',
      detail: 'Open-air • events at times',
      icon: Icons.deck_outlined,
    ),
    CampusSpace(
      id: 'gym',
      name: 'Gym',
      category: 'Fitness',
      detail: 'Equipment • peak evenings',
      icon: Icons.fitness_center_outlined,
    ),
    CampusSpace(
      id: 'swimming-pool',
      name: 'Swimming Pool',
      category: 'Fitness',
      detail: 'Lanes • timing slots',
      icon: Icons.pool_outlined,
    ),
  ];

  static const libraryFloors = ['1F', '2F', '3F'];
}
