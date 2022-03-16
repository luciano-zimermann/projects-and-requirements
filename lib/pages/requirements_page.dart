import 'package:flutter/material.dart';
import 'package:projects_and_requirements/util/requereasy_tech_form_field.dart';
import 'package:validatorless/validatorless.dart';

class RequirementsPage extends StatefulWidget {
  const RequirementsPage({Key? key}) : super(key: key);

  @override
  State<RequirementsPage> createState() => _RequirementsPageState();
}

class _RequirementsPageState extends State<RequirementsPage> {
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
                  controller: prjNameController,
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Data de registro",
                  controller: prjStartDateController,
                  validator: Validatorless.multiple([
                    Validatorless.max(6, "Informe a data no formato yyMMdd!"),
                    Validatorless.date("Formato de data inválido!"),
                  ]),
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Importância",
                  controller: prjOwnerController,
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Complexidade",
                  controller: prjOwnerController,
                ),
                const SizedBox(height: 25),
                RequereasyTechFormField(
                  label: "Tempo Estimado",
                  controller: prjOwnerController,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: ElevatedButton(
                    onPressed: () {
                      createSuccessAlertDialog(context);
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

  createSuccessAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sucesso!"),
          content: const Text("Requisito cadastrado com sucesso!"),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
