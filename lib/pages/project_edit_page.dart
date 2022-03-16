import 'package:flutter/material.dart';
import 'package:projects_and_requirements/util/requereasy_tech_form_field.dart';
import 'package:validatorless/validatorless.dart';

class ProjectEditPage extends StatefulWidget {
  const ProjectEditPage({Key? key}) : super(key: key);

  @override
  State<ProjectEditPage> createState() => _ProjectEditPageState();
}

class _ProjectEditPageState extends State<ProjectEditPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController prjNameController = TextEditingController();
  TextEditingController prjStartDateController = TextEditingController();
  TextEditingController prjEstimatedEndDateController = TextEditingController();
  TextEditingController prjOwnerController = TextEditingController();

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
                  controller: prjNameController,
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Data de ínicio",
                  controller: prjStartDateController,
                  validator: Validatorless.multiple([
                    Validatorless.max(6, "Informe a data no formato yyMMdd!"),
                    Validatorless.date("Formato de data inválido!"),
                  ]),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Data fim estimada",
                  controller: prjEstimatedEndDateController,
                  validator: Validatorless.multiple([
                    Validatorless.max(6, "Informe a data no formato yyMMdd!"),
                    Validatorless.date("Formato de data inválido!"),
                  ]),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Responsável",
                  controller: prjOwnerController,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: ElevatedButton(
                    onPressed: () {},
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
}
