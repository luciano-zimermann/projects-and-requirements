import 'package:flutter/material.dart';
import 'package:projects_and_requirements/pages/project_edit_page.dart';
import 'package:projects_and_requirements/pages/project_page.dart';
import 'package:projects_and_requirements/pages/requirements_edit_page.dart';
import 'package:projects_and_requirements/pages/requirements_page.dart';

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPage();
}

class _ProjectDetailsPage extends State<ProjectDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes do Projeto',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Detalhes do Projeto',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 220,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Nome: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Projeto Teste',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: const [
                                Text(
                                  'Data de Início: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '03/02/2099',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: const [
                                Text(
                                  'Data Fim Estimada: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '01/07/2099',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: const [
                                Text(
                                  'Responsável: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Fulano Silveira',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Row(
                children: const [
                  Text(
                    'Requisitos Cadastrados',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Requisito: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            'REQ${index + 1}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: const [
                                          Text(
                                            'Descrição: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: const [
                                          Flexible(
                                            child: Text(
                                              'Cadastrar projetos, para que dentro destes projetos, '
                                              'seja possível cadastrar requisitos com o objetivo de um gerenciamento mais eficaz.',
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 20,
                                              ),
                                              maxLines: 5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: const [
                                          Text(
                                            'Data de Registro: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            '03/07/2099',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: const [
                                          Text(
                                            'Importância: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            'Alta',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: const [
                                          Text(
                                            'Complexidade: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            'Alta',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: const [
                                          Text(
                                            'Tempo Estimado: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            '50 horas',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const RequirementsEditPage(),
                                            ),
                                          );
                                        },
                                        child: const Text('Editar Requisito'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            createDeleteAlertDialog(
                                                context, 'Requisito'),
                                        child: const Text('Excluir Requisito'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequirementsPage(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Cadastrar Novo Requisito',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 55, right: 55, top: 15, bottom: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProjectEditPage(),
                    ),
                  );
                },
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 55, right: 55, top: 15, bottom: 15),
                  child: Text(
                    'Editar Projeto',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () => createDeleteAlertDialog(context, 'Projeto'),
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 55, right: 55, top: 15, bottom: 15),
                  child: Text(
                    'Excluir Projeto',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  createDeleteAlertDialog(BuildContext context, String item) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Atenção!"),
          content: Text("Deseja realmente excluir esse $item?"),
          actions: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Sim"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
              style: ElevatedButton.styleFrom(primary: Colors.grey),
            ),
          ],
        );
      },
    );
  }
}
