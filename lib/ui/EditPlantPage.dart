import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:regapp/models/Plant.dart';
import 'package:regapp/service/NotificationService.dart';
import 'package:regapp/ui/components/WeekFrequencyInput.dart';

class EditPlantPage extends StatefulWidget {
  final String id;
  const EditPlantPage({required this.id, super.key});

  @override
  _EditPlantPageState createState() => _EditPlantPageState();
}

class _EditPlantPageState extends State<EditPlantPage> {
  String fileName = '';
  PlatformFile? pickedFile;
  String? _selectedLocation = '';
  Set<String> _frequency = {};
  TimeOfDay? _time;

  Plant? _plant;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();

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
    _frequency = newFrequency;
  }

  Future<String> _uploadImageToStorage(File imageFile) async {
    User? loggedInUser = FirebaseAuth.instance.currentUser;
    if (loggedInUser == null) return '';
    String userId = loggedInUser.uid;

    if (_plant == null) {
      return '';
    }

    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('users/$userId/plants/${_plant!.id}');

    try {
      TaskSnapshot snapshot = await storageRef.putFile(imageFile);
      String fileUrl = await snapshot.ref.getDownloadURL();
      return fileUrl;
    } on FirebaseException catch (e) {
      return '$e';
    }
  }

  void _handleSavePlant() async {
    try {
      String imageUrl = '';
      if (pickedFile != null && pickedFile!.path != null) {
        File firebaseFile = File(pickedFile!.path!);
        imageUrl = await _uploadImageToStorage(firebaseFile);
      }
      var userId = FirebaseAuth.instance.currentUser?.uid;
      DocumentReference plantDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('plants')
          .doc(widget.id);
      int plantId = 0;
      DocumentSnapshot snapshot = await plantDocRef.get();
      if (snapshot.exists) {
        plantId = snapshot.get('plantId');
        if (pickedFile == null) {
          imageUrl = snapshot.get('ímageUrl');
        }
      } else {
        throw Error();
      }

      if (_time == null) {
        throw Error();
      }
      await plantDocRef.update({
        'title': _nameController.text.trim(),
        'imageUrl': imageUrl,
        'waterNeeds': _volumeController.text.trim(),
        'location': _selectedLocation,
        'frequency': _frequency,
        'time': '${_time!.hour}:${_time!.minute}',
      });
      NotificationService.cancelAllPlantNotifications(plantId);
      NotificationService.addPlantNotifications(_nameController.text.trim(),
          plantId, _frequency, _time!.hour, _time!.minute);
    } catch (e) {
      print('Error saving plant: $e');
    }
  }

  void _identifyPlant() {
    // if success
    _nameController.text = 'Samambaia';
    _volumeController.text = '300 ml';
    // if error
    context.push('/plants/identifyPlantError');
  }

  Future<void> _selectTime() async {
    TimeOfDay? chosen = await showTimePicker(
      initialTime: _time!,
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

  @override
  void initState() {
    super.initState();
    _loadPlantData();
  }

  void _loadPlantData() async {
    _plant = await fetchPlantInfo();

    if (_plant != null) {
      setState(() {
        _nameController.text = _plant!.title;
        _volumeController.text = _plant!.waterNeeds;
        _frequency = _plant!.frequency;
        var parts = _plant!.time.split(':');
        _time =
            TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
        _selectedLocation = _plant!.location;
      });
    }
  }

  Future<Plant?> fetchPlantInfo() async {
    try {
      DocumentSnapshot plantDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('plants')
          .doc(widget.id)
          .get();

      if (plantDoc.exists) {
        Map<String, dynamic> data = plantDoc.data() as Map<String, dynamic>;
        return Plant(
            id: widget.id,
            title: data['title'],
            imageUrl: data['imageUrl'],
            waterNeeds: data['waterNeeds'].toString(),
            location: data['location'],
            frequency: Set<String>.from(data['frequency']),
            time: data['time']);
      } else {
        print('Plant not found');
        return null;
      }
    } catch (e) {
      print('Error fetching plant info: $e');
      return null;
    }
  }

  Widget _getPlantImage() {
    if (pickedFile != null && pickedFile!.bytes != null) {
      return Image.memory(
        pickedFile!.bytes!,
        fit: BoxFit.cover,
      );
    } else if (_plant != null && _plant!.imageUrl != '') {
      return Image.network(
        _plant!.imageUrl,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Editar Planta",
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
                    controller: _nameController,
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
                    controller: _volumeController,
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
                      groupValue: _selectedLocation,
                      onChanged: (value) {
                        setState(() {
                          _selectedLocation = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Externa',
                        style: Theme.of(context).textTheme.bodyLarge),
                    leading: Radio(
                      value: 'Externa',
                      groupValue: _selectedLocation,
                      onChanged: (value) {
                        setState(() {
                          _selectedLocation = value;
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
                    defaultFreq: _frequency,
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
                            _time != null
                                ? "${_time?.hour}:${_time?.minute.toString().padLeft(2, '0')}"
                                : "",
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
                    onPressed: () {
                      _handleSavePlant();
                      context.pop();
                    },
                    child: Text(
                      'Salvar planta',
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
