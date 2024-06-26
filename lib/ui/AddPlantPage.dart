import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:regapp/models/Plant.dart';
import 'package:regapp/providers/SettingsProvider.dart';
import 'package:regapp/service/NotificationService.dart';
import 'package:regapp/ui/components/WeekFrequencyInput.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  _AddPlantPageState createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final User? _loggedInUser = FirebaseAuth.instance.currentUser;
  String fileName = '';
  PlatformFile? pickedFile;
  String? selectedOption = '';
  Set<String> frequency = {'Ter', 'Qui', 'Sab'};
  TimeOfDay _time = TimeOfDay.now();

  TextEditingController nameController = TextEditingController();
  TextEditingController volumeController = TextEditingController();

  void openFilePicker() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(withData: true);

    if (result != null) {
      setState(() {
        pickedFile = result.files.first;
        fileName = pickedFile!.name;
      });
    }
  }

  void _handleFreqChange(newFrequency) {
    frequency = newFrequency;
  }

  void _identifyPlant() {
    // if success
    nameController.text = 'Samambaia';
    volumeController.text = '300 ml';
    // if error
    context.push('/plants/identifyPlantError');
  }

  Future<void> _selectTime() async {
    TimeOfDay? chosen = await showTimePicker(
      initialTime: _time,
      context: context,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );

    if (chosen != null) {
      setState(() => _time = chosen);
    }
  }

  Future<String> _uploadImageToStorage(File imageFile, String plantId) async {
    User? loggedInUser = FirebaseAuth.instance.currentUser;
    if (loggedInUser == null) return '';
    String userId = loggedInUser.uid;

    final Reference storageRef =
        FirebaseStorage.instance.ref().child('users/$userId/plants/$plantId');

    try {
      TaskSnapshot snapshot = await storageRef.putFile(imageFile);
      String fileUrl = await snapshot.ref.getDownloadURL();
      return fileUrl;
    } on FirebaseException catch (e) {
      return '$e';
    }
  }

  Future<void> _savePlant(SettingsProvider settingsProvider) async {
    try {
      String? userId = _loggedInUser?.uid;
      var plantCountSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('plants')
          .count()
          .get();
      int? plantCount = plantCountSnapshot.count;
      if (plantCount == null) {
        throw Error();
      }
      DocumentReference newPlant = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('plants')
          .add({
        'plantId': plantCount,
        'title': nameController.text.trim(),
        'imageUrl': '',
        'waterNeeds': volumeController.text.trim(),
        'location': selectedOption,
        'frequency': frequency,
        'time': '${_time.hour}:${_time.minute}',
      });
      String imageUrl = '';
      if (pickedFile != null && pickedFile!.path != null) {
        File firebaseFile = File(pickedFile!.path!);
        imageUrl = await _uploadImageToStorage(firebaseFile, newPlant.id);
      }
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('plants')
          .doc(newPlant.id)
          .update({
        'imageUrl': imageUrl,
      });
      if (settingsProvider.notificationsEnabled) {
        NotificationService.addPlantNotifications(
            nameController.text.trim(),
            plantCount,
            frequency,
            _time.hour,
            _time.minute,
            NotificationService.providerToSettings(settingsProvider));
      }
    } catch (e) {
      print('Error saving plant: $e');
    }
  }

  Widget _getPlantImage() {
    if (pickedFile != null && pickedFile!.bytes != null) {
      return Image.memory(
        pickedFile!.bytes!,
        fit: BoxFit.cover,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(
          'assets/icons/pottedPlantIcon.png',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Adicionar Planta",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 180,
                  width: 180,
                  child: Stack(
                    children: [
                      ClipOval(
                        child: Container(
                          color: const Color(0XFF59CD90),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 1.0,
                        child: ClipOval(
                          child: _getPlantImage(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF7ca40c))),
                    onPressed: () => _identifyPlant(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.center_focus_strong_outlined),
                        ),
                        Text(
                          'Identificar planta',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      'Imagem',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextFormField(
                    readOnly: true,
                    onTap: openFilePicker,
                    decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            labelText: 'Escolha uma imagem',
                            suffixIcon: const Icon(Icons.attach_file),
                            hintStyle: Theme.of(context).textTheme.bodyLarge)
                        .copyWith(
                      hintStyle:
                          const TextStyle(color: Color.fromARGB(128, 0, 0, 0)),
                      hintText: fileName.isEmpty
                          ? 'Imagem não selecionada'
                          : fileName,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      'Nome',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: 'Ex: Samambaia01',
                            hintStyle: Theme.of(context).textTheme.bodyLarge)
                        .copyWith(
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(128, 0, 0, 0))),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
                    child: Text(
                      'Volume de água',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextFormField(
                    controller: volumeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                            suffixText: 'ml',
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: 'Ex: 200 ml',
                            hintStyle: Theme.of(context).textTheme.bodyLarge)
                        .copyWith(
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(128, 0, 0, 0))),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
                    child: Text(
                      'Ambiente',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ListTile(
                    title: Text('Interna',
                        style: Theme.of(context).textTheme.bodyLarge),
                    leading: Radio(
                      value: 'Interna',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Externa',
                        style: Theme.of(context).textTheme.bodyLarge),
                    leading: Radio(
                      value: 'Externa',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Frequência',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  WeekFrequencyInput(
                    onFreqChange: _handleFreqChange,
                    defaultFreq: frequency,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 4),
                    child: Text(
                      'Hora',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                        onTap: () => _selectTime(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${_time.hour}:${_time.minute.toString().padLeft(2, '0')}",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        )),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _savePlant(settingsProvider);
                      if (context.mounted) context.pop();
                    },
                    child: Text(
                      'Adicionar planta',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
