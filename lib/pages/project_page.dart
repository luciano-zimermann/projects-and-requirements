import 'package:flutter/material.dart';
import 'package:projects_and_requirements/database/database.dart';
import 'package:projects_and_requirements/models/project.dart';
import 'package:projects_and_requirements/pages/projects_list_page.dart';
import 'package:projects_and_requirements/util/requereasy_tech_form_field.dart';
import 'package:sqflite/sqflite.dart';
import 'package:validatorless/validatorless.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController prjNameController = TextEditingController();
  TextEditingController prjStartDateController = TextEditingController();
  TextEditingController prjEstimatedEndDateController = TextEditingController();
  TextEditingController prjOwnerController = TextEditingController();

  static DatabaseHelper? db;

  int size = 0;
  List<Project> projects = [];

  @override
  void initState() {
    db = DatabaseHelper();

    db!.initDB();

    Future<List<Project>> projectsList = db!.getProjects();

    projectsList.then((newProjectsList) {
      setState(() {
        projects = newProjectsList;
        size = newProjectsList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro de Projeto',
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
                  padding: EdgeInsets.only(left: 75),
                  child: Text(
                    'Criar novo Projeto',
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
                    'Preencha os campos abaixo para criar um projeto!',
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
                  controller: prjNameController,
                  validator: Validatorless.required('Nome obrigatório!'),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Data de ínicio",
                  controller: prjStartDateController,
                  validator:
                      Validatorless.required("Data de início obrigatória!"),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Data fim estimada",
                  controller: prjEstimatedEndDateController,
                  validator:
                      Validatorless.required("Data fim estimada obrigatória!"),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Responsável",
                  controller: prjOwnerController,
                  validator: Validatorless.required("Responsável obrigatório!"),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final String name = prjNameController.text;
                        final String startDate = prjStartDateController.text;
                        final String estimatedEndDate =
                            prjEstimatedEndDateController.text;
                        final String owner = prjOwnerController.text;

                        var _newDBProject =
                            Project(name, startDate, estimatedEndDate, owner);

                        db!.insertProject(_newDBProject);

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
          content: const Text("Projeto cadastrado com sucesso!"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, ProjectsListPage.route());
              },
              child: const Text("Ok"),

            ),
          ],
        );
      },
    );
  }
}
