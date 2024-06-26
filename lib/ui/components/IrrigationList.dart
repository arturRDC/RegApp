import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:regapp/models/Plant.dart';
import 'package:regapp/ui/components/IrrigationCard.dart';

enum IrrigationOptions {
  today,
  next,
  all,
}

class IrrigationList extends StatefulWidget {
  final IrrigationOptions options;
  const IrrigationList({required this.options, super.key});

  @override
  State<IrrigationList> createState() => _IrrigationListState();
}

class _IrrigationListState extends State<IrrigationList> {
  List<Plant>? plants;

  @override
  void initState() {
    super.initState();
  }

  Map<String, int> weekdayMap = {
    'Seg': DateTime.monday,
    'Ter': DateTime.tuesday,
    'Qua': DateTime.wednesday,
    'Qui': DateTime.thursday,
    'Sex': DateTime.friday,
    'Sab': DateTime.saturday,
    'Dom': DateTime.sunday,
  };

  DateTime _getNextIrrigation(Set<String> dayAbbrs, String timeString) {
    final now = DateTime.now();
    var targetWeekdays = dayAbbrs.map((abbr) => weekdayMap[abbr] ?? -1).toSet();

    if (targetWeekdays.contains(-1)) {
      throw ArgumentError('Invalid day abbreviation');
    }

    // Parse the time string
    List<String> timeParts = timeString.split(':');
    if (timeParts.length != 2) {
      throw ArgumentError('Invalid time format. Use HH:MM');
    }

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      throw ArgumentError('Invalid time values');
    }

    DateTime closest =
        now.add(const Duration(days: 7)); // Start with a week from now

    for (int i = 0; i < 7; i++) {
      var candidate = now.add(Duration(days: i));
      candidate = DateTime(
          candidate.year, candidate.month, candidate.day, hour, minute);

      if (targetWeekdays.contains(candidate.weekday) &&
          candidate.isAfter(now)) {
        if (candidate.isBefore(closest)) {
          closest = candidate;
        }
      }
    }
    return closest;
  }

  Stream<QuerySnapshot> getPlantsStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('plants')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getPlantsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitDualRing(
              color: Colors.green,
              size: 50.0,
            );
          }
          if (snapshot.data == null) {
            return const SpinKitDualRing(
              color: Colors.green,
              size: 50.0,
            );
          }
          List<Plant> plants = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            Plant plant = Plant(
                id: doc.id,
                title: data['title'],
                imageUrl: data['imageUrl'],
                waterNeeds: data['waterNeeds'].toString(),
                location: data['location'],
                frequency: Set<String>.from(data['frequency']),
                time: data['time'],
                nextIrrigation: _getNextIrrigation(
                    Set<String>.from(data['frequency']), data['time']));
            return plant;
          }).toList();

          plants.sort((a, b) {
            if (a.nextIrrigation == null && b.nextIrrigation == null) {
              return 0;
            } else if (a.nextIrrigation == null) {
              return 1;
            } else if (b.nextIrrigation == null) {
              return -1;
            } else {
              return a.nextIrrigation!.compareTo(b.nextIrrigation!);
            }
          });
          List<Plant> irrigations = List.empty();
          switch (widget.options) {
            case IrrigationOptions.today:
              irrigations = plants.where((pl) {
                if (pl.nextIrrigation != null &&
                    pl.nextIrrigation?.day == DateTime.now().day) {
                  return true;
                } else {
                  return false;
                }
              }).toList();
              break;
            case IrrigationOptions.next:
              irrigations = plants.where((pl) {
                if (pl.nextIrrigation != null &&
                    pl.nextIrrigation?.day != DateTime.now().day) {
                  return true;
                } else {
                  return false;
                }
              }).toList();
            case IrrigationOptions.all:
              irrigations = plants.where((pl) {
                return pl.nextIrrigation != null;
              }).toList();
            default:
          }
          return ListView.builder(
            itemCount: min(irrigations.length, 4),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return IrrigationCard(
                title: irrigations[index].title,
                nextIrrigation: irrigations[index].nextIrrigation!,
                waterNeeds: irrigations[index].waterNeeds.toString(),
                location: irrigations[index].location,
                imageUrl: irrigations[index].imageUrl,
              );
            },
          );
        });
  }
}
