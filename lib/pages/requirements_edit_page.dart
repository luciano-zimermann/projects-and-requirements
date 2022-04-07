import 'package:flutter/material.dart';
import 'package:projects_and_requirements/database/database.dart';
import 'package:projects_and_requirements/models/project.dart';
import 'package:projects_and_requirements/models/requirements.dart';
import 'package:projects_and_requirements/pages/project_details_page.dart';
import 'package:projects_and_requirements/util/requereasy_tech_form_field.dart';
import 'package:validatorless/validatorless.dart';

class RequirementsEditPage extends StatefulWidget {
  static route(Requirement requirement, Project project, int index) =>
      MaterialPageRoute(
        builder: (context) => RequirementsEditPage(
          requirement: requirement,
          project: project,
          index: index,
        ),
      );

  const RequirementsEditPage({
    Key? key,
    required this.requirement,
    required this.project,
    required this.index,
  }) : super(key: key);

  final Requirement? requirement;
  final Project? project;
  final int? index;

  @override
  State<RequirementsEditPage> createState() => _RequirementsEditPageState();
}

class _RequirementsEditPageState extends State<RequirementsEditPage> {
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
  initState() {
    db = DatabaseHelper();

    db!.initDB();

    reqDescriptionController.text = widget.requirement?.description ?? '';
    reqRegisterDateController.text = widget.requirement?.registerDate ?? '';
    reqImportanceController.text = widget.requirement?.importance ?? '';
    reqComplexityController.text = widget.requirement?.complexity ?? '';
    reqEstimatedTimeController.text = widget.requirement?.estimatedTime ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editor de Requisito',
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
                    'Atualizar Requisito',
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
                    'Preencha os campos abaixo para editar o requisito!',
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
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Data de registro",
                  controller: reqRegisterDateController,
                  validator: Validatorless.required("Data de registro obrigatória!"),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Importância",
                  controller: reqImportanceController,
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Complexidade",
                  controller: reqComplexityController,
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Tempo Estimado",
                  controller: reqEstimatedTimeController,
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

                        var newDBRequirement = Requirement(
                          description,
                          registerDate,
                          importance,
                          complexity,
                          estimatedTime,
                          widget.requirement?.refProject,
                          widget.requirement?.location,
                          widget.requirement?.image1,
                          widget.requirement?.image2
                        );
                        db!.updateRequirement(
                            newDBRequirement, widget.requirement?.id);

                        _createSuccessfulUpdatedAlertDialog(context);

                        setState(() {});
                      }
                    },
                    child: const Text('Atualizar'),
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

  _createSuccessfulUpdatedAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Requisito atualizado com sucesso!"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push((context),
                    ProjectDetailsPage.route(widget.project!, widget.index!));
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
