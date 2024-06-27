import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regapp/models/Plant.dart';
import 'package:regapp/ui/components/PlantCard.dart';

class PlantList extends StatefulWidget {
  const PlantList({super.key});

  @override
  State<PlantList> createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  List<Plant>? plants;

  @override
  void initState() {
    super.initState();
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
            return const CircularProgressIndicator();
          }
          if (snapshot.data == null) return const CircularProgressIndicator();
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
            );
            return plant;
          }).toList();

          return ListView.builder(
            itemCount: plants.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return PlantCard(
                id: plants[index].id,
                title: plants[index].title,
                time: plants[index].time,
                waterNeeds: plants[index].waterNeeds.toString(),
                location: plants[index].location,
              );
            },
          );
        });
  }
}
