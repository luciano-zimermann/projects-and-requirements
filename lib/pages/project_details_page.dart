import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projects_and_requirements/database/database.dart';
import 'package:projects_and_requirements/models/project.dart';
import 'package:projects_and_requirements/models/requirements.dart';
import 'package:projects_and_requirements/pages/project_edit_page.dart';
import 'package:projects_and_requirements/pages/projects_list_page.dart';
import 'package:projects_and_requirements/pages/requirements_edit_page.dart';
import 'package:projects_and_requirements/pages/requirements_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsPage extends StatefulWidget {
  static route(Project project, int index) => MaterialPageRoute(
        builder: (context) => ProjectDetailsPage(
          project: project,
          index: index,
        ),
      );

  const ProjectDetailsPage({
    Key? key,
    required this.project,
    required this.index,
  }) : super(key: key);

  final Project? project;

  final int? index;

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPage();
}

class _ProjectDetailsPage extends State<ProjectDetailsPage> {
  static DatabaseHelper? db;

  int projectsSize = 0;
  int requirementsSize = 0;
  List<Project> projects = [];
  List<Requirement> requirements = [];

  @override
  initState() {
    db = DatabaseHelper();

    db!.initDB();

    Future<List<Project>> projectsList = db!.getProjects();

    projectsList.then((newProjectsList) {
      setState(() {
        projects = newProjectsList;
        projectsSize = newProjectsList.length;
      });
    });

    Future<List<Requirement>> requirementsList =
        db!.getRequirements(widget.project!.id!);

    requirementsList.then((newRequirementsList) {
      setState(() {
        requirements = newRequirementsList;
        requirementsSize = newRequirementsList.length;
      });
    });
  }

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
                              children: [
                                const Text(
                                  'Nome: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${widget.project!.name}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text(
                                  'Data de Início: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '${widget.project!.startDate}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text(
                                  'Data Fim Estimada: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '${widget.project!.estimatedEndDate}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text(
                                  'Responsável: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '${widget.project!.owner}',
                                  style: const TextStyle(
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
            FutureBuilder<List<Requirement>>(
              future: db!.getRequirements(widget.project!.id!),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Requirement>> snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Requirement req = snapshot.data![index];

                          File image1 = File(req.image1.toString());
                          File image2 = File(req.image2.toString());

                          return SizedBox(
                            height: 1200,
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
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  '${req.description}',
                                                  style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 20,
                                                  ),
                                                  maxLines: 5,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Text(
                                                'Data de Registro: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                '${req.registerDate}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Text(
                                                'Importância: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                '${req.importance}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Text(
                                                'Complexidade: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                '${req.complexity}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Text(
                                                'Tempo Estimado: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                '${req.estimatedTime}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Text(
                                                'Local Cadastrado: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '${req.location}',
                                                  style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                'Link para Documentação Complementar: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  '${req.complementInfoLink}',
                                                  style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 20,
                                                  ),
                                                  maxLines: 5,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 120.0),
                                            child: Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () => _accessLink(
                                                      req.complementInfoLink!),
                                                  child: const Text(
                                                      'Acessar Link'),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Center(
                                            child: Image.file(
                                              image1,
                                              width: 300,
                                              height: 300,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Center(
                                            child: Image.file(
                                              image2,
                                              width: 300,
                                              height: 300,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RequirementsEditPage(
                                                    project: widget.project!,
                                                    index: widget.index!,
                                                    requirement: req,
                                                  ),
                                                ),
                                              );
                                            },
                                            child:
                                                const Text('Editar Requisito'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              createDeleteRequirementAlertDialog(
                                                context,
                                                req,
                                                index,
                                              );
                                            },
                                            child:
                                                const Text('Excluir Requisito'),
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
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RequirementsPage(
                        projectId: widget.project?.id,
                        project: widget.project!,
                        index: widget.index!,
                      ),
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
                      builder: (context) => ProjectEditPage(
                        project: widget.project,
                      ),
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
                onPressed: () => createDeleteProjectAlertDialog(
                    context, widget.project, widget.index),
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

  createDeleteRequirementAlertDialog(
      BuildContext context, Requirement requirement, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Atenção!"),
          content: const Text("Deseja realmente excluir esse Requisito?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                _deleteRequirement(requirement, index);
                Navigator.pop(context);
              },
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

  createDeleteProjectAlertDialog(
      BuildContext context, Project? project, int? index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Atenção!"),
          content: const Text("Deseja realmente excluir esse Projeto?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                _deleteProject(project!, index!);
              },
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

  _deleteProject(Project project, int? index) {
    setState(() {
      db!.deleteProject(project.id!);

      projectsSize = projectsSize - 1;

      Navigator.push(context, ProjectsListPage.route());
    });
  }

  _deleteRequirement(Requirement requirement, int index) {
    setState(() {
      db!.deleteRequirement(requirement.id!);

      requirementsSize = requirementsSize - 1;
    });
  }

  void _accessLink(String url) async {
    if (await canLaunch('https:$url')) {
      await launch(
        'https:$url',
        enableJavaScript: true,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro ao acessar o link $url',
            style: const TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.grey,
        ),
      );
    }
  }
}
