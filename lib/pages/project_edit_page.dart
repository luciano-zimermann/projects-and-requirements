import 'package:flutter/material.dart';
import 'package:projects_and_requirements/database/database.dart';
import 'package:projects_and_requirements/models/project.dart';
import 'package:projects_and_requirements/pages/projects_list_page.dart';
import 'package:projects_and_requirements/util/requereasy_tech_form_field.dart';
import 'package:validatorless/validatorless.dart';

class ProjectEditPage extends StatefulWidget {
  const ProjectEditPage({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project? project;

  @override
  State<ProjectEditPage> createState() => _ProjectEditPageState();
}

class _ProjectEditPageState extends State<ProjectEditPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _prjNameController = TextEditingController();
  final TextEditingController _prjStartDateController = TextEditingController();
  final TextEditingController _prjEstimatedEndDateController =
      TextEditingController();
  final TextEditingController _prjOwnerController = TextEditingController();

  static DatabaseHelper? db;

  int size = 0;
  List<Project> projects = [];

  @override
  void initState() {
    db = DatabaseHelper();

    db!.initDB();

    _prjNameController.text = widget.project?.name ?? '';
    _prjStartDateController.text = widget.project?.startDate ?? '';
    _prjEstimatedEndDateController.text =
        widget.project?.estimatedEndDate ?? '';
    _prjOwnerController.text = widget.project?.owner ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edição de Projeto',
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
                  padding: EdgeInsets.only(left: 85),
                  child: Text(
                    'Atualizar Projeto',
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
                    'Preencha os campos abaixo para atualizar o projeto!',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                RequereasyTechFormField(
                  label: 'Nome do Projeto',
                  controller: _prjNameController,
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Data de ínicio",
                  controller: _prjStartDateController,
                  validator: Validatorless.required('Data de Início Obrigatória!'),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Data fim estimada",
                  controller: _prjEstimatedEndDateController,
                  validator: Validatorless.required('Data Fim Estimada Obrigatória!')
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Responsável",
                  controller: _prjOwnerController,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final String name = _prjNameController.text;
                        final String startDate = _prjStartDateController.text;
                        final String estimatedEndDate =
                            _prjEstimatedEndDateController.text;
                        final String owner = _prjOwnerController.text;

                        var newDBProject = Project(
                          name,
                          startDate,
                          estimatedEndDate,
                          owner,
                        );

                        db!.updateProject(newDBProject, widget.project?.id);

                        _createSuccessfulUpdatedAlertDialog(context);
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
          title: const Text("Projeto atualizado com sucesso!"),
          actions: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.push(context, ProjectsListPage.route()),
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
