import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:regapp/ui/components/WeekFrequencyInput.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  _AddPlantPageState createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  String fileName = '';
  PlatformFile? pickedFile;
  String? selectedOption = '';
  Set<String> frequency = {'Ter', 'Qui', 'Sab'};

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

  @override
  Widget build(BuildContext context) {
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
                          child:
                              (pickedFile != null && pickedFile!.bytes != null)
                                  ? Image.memory(
                                      pickedFile!.bytes!,
                                      fit: BoxFit.cover,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        'assets/icons/pottedPlantIcon.png',
                                      ),
                                    ),
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
                    onPressed: () {
                      // Handle form submission
                    },
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
                    decoration: InputDecoration(
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle form submission
                      context.pop();
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
