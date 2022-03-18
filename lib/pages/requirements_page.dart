import 'package:flutter/material.dart';
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

                        var newDBRequirement = Requirement(
                          description,
                          registerDate,
                          importance,
                          complexity,
                          estimatedTime,
                          refProject,
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
