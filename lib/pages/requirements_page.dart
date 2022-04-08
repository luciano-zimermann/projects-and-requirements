import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projects_and_requirements/database/database.dart';
import 'package:projects_and_requirements/models/project.dart';
import 'package:projects_and_requirements/models/requirements.dart';
import 'package:projects_and_requirements/pages/project_details_page.dart';
import 'package:projects_and_requirements/util/requereasy_tech_form_field.dart';
import 'package:validatorless/validatorless.dart';

class RequirementsPage extends StatefulWidget {
  const RequirementsPage({
    Key? key,
    required this.projectId,
    required this.project,
    required this.index,
  }) : super(key: key);

  final int? projectId;

  final Project? project;
  final int? index;

  @override
  State<RequirementsPage> createState() => _RequirementsPageState();
}

class _RequirementsPageState extends State<RequirementsPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController reqDescriptionController = TextEditingController();
  TextEditingController reqRegisterDateController = TextEditingController();
  TextEditingController reqImportanceController = TextEditingController();
  TextEditingController reqComplexityController = TextEditingController();
  TextEditingController reqEstimatedTimeController = TextEditingController();
  TextEditingController reqComplementInfoLinkController = TextEditingController();

  static DatabaseHelper? db;

  int size = 0;
  List<Requirement> requirements = [];

  @override
  void initState() {
    db = DatabaseHelper();

    db!.initDB();

    Future<List<Requirement>> requirementsList =
        db!.getRequirements(widget.projectId!);

    requirementsList.then((newRequirementsList) {
      setState(() {
        requirements = newRequirementsList;
        size = newRequirementsList.length;
      });
    });
  }

  Position? _currentPosition;
  String? _currentAddress;
  bool isLoadingLocation = false;

  FilePickerResult? result1;
  PlatformFile? image1;

  FilePickerResult? result2;
  PlatformFile? image2;

  void loadLocation() async {
    setState(() {
      isLoadingLocation = true;
    });

    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    ).then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
        isLoadingLocation = false;
      });
    }).catchError((e) {
      print(e);
    });
  }

  void pickFile() async {
    result1 = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result1 == null) return;

    image1 = result1!.files.first;

    setState(() {});
  }

  void pickFile2() async {
    result2 = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result2 == null) return;

    image2 = result2!.files.first;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro de Requisito',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    'Cadastrar novo Requisito',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Preencha os campos abaixo para cadastrar um requisito!',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                RequereasyTechFormField(
                  label: 'Descrição do Requisito',
                  controller: reqDescriptionController,
                  validator: Validatorless.required("Descrição obrigatória!"),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Data de registro",
                  controller: reqRegisterDateController,
                  validator:
                      Validatorless.required("Data de Registro obrigatória!"),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Importância",
                  controller: reqImportanceController,
                  validator: Validatorless.required("Importância obrigatória!"),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Complexidade",
                  controller: reqComplexityController,
                  validator:
                      Validatorless.required("Complexidade obrigatória!"),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Tempo Estimado",
                  controller: reqEstimatedTimeController,
                  validator:
                      Validatorless.required("Tempo estimado obrigatório!"),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Link para informação complementar",
                  controller: reqComplementInfoLinkController,
                  validator:
                  Validatorless.required("Link obrigatório!"),
                ),
                const SizedBox(height: 25),
                Center(
                  child: isLoadingLocation
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            _currentAddress ?? '',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 120.0),
                  child: ElevatedButton(
                    onPressed: () => loadLocation(),
                    child: const Text("Obter Localização"),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 90.0),
                  child: Row(
                    children: [
                      // ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ElevatedButton(
                            onPressed: () => pickFile(),
                            child: const Text('Foto 1'),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ElevatedButton(
                            onPressed: () => pickFile2(),
                            child: const Text('Foto 2'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    (image1 == null)
                        ? Container()
                        : Center(
                            child: Image.file(
                              File(image1!.path.toString()),
                              width: 300,
                              height: 300,
                            ),
                          ),
                    const SizedBox(height: 20),
                    (image2 == null)
                        ? Container()
                        : Center(
                            child: Image.file(
                              File(image2!.path.toString()),
                              width: 300,
                              height: 300,
                            ),
                          ),
                  ],
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final String description =
                            reqDescriptionController.text;
                        final String registerDate =
                            reqRegisterDateController.text;
                        final String importance = reqImportanceController.text;
                        final String complexity = reqComplexityController.text;
                        final String estimatedTime =
                            reqEstimatedTimeController.text;
                        final int refProject = widget.projectId!;
                        final String link = reqComplementInfoLinkController.text;
                        final String location =
                            _currentAddress ?? 'Não Informado';

                        var newDBRequirement = Requirement(
                          description,
                          registerDate,
                          importance,
                          complexity,
                          estimatedTime,
                          refProject,
                          link,
                          location,
                          image1!.path.toString(),
                          image2!.path.toString(),
                        );

                        db!.insertRequirement(newDBRequirement);

                        _createSuccessAlertDialog(context);
                      }
                    },
                    child: const Text('Cadastrar'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                      maximumSize: const Size(200, 50),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.street}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  _createSuccessAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sucesso!"),
          content: const Text("Requisito cadastrado com sucesso!"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectDetailsPage(
                      project: widget.project,
                      index: widget.index,
                    ),
                  ),
                );
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
