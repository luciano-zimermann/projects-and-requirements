import 'package:flutter/material.dart';
import 'package:projects_and_requirements/util/requereasy_tech_form_field.dart';
import 'package:validatorless/validatorless.dart';

class RequirementsEditPage extends StatefulWidget {
  const RequirementsEditPage({Key? key}) : super(key: key);

  @override
  State<RequirementsEditPage> createState() => _RequirementsEditPageState();
}

class _RequirementsEditPageState extends State<RequirementsEditPage> {
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
