import 'package:flutter/material.dart';
import 'package:projects_and_requirements/database/database.dart';
import 'package:projects_and_requirements/models/project.dart';
import 'package:projects_and_requirements/pages/project_details_page.dart';

class ProjectsListPage extends StatefulWidget {
  const ProjectsListPage({Key? key}) : super(key: key);

  static route() =>
      MaterialPageRoute(builder: (context) => const ProjectsListPage());

  @override
  State<ProjectsListPage> createState() => _ProjectsListPageState();
}

class _ProjectsListPageState extends State<ProjectsListPage> {
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
          'Projetos cadastrados',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: FutureBuilder<List<Project>>(
        future: db!.getProjects(),
        builder: (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Project project = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text(
                          '${project.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      subtitle: Text('Responsável: ${project.owner}'),
                      trailing: const Icon(Icons.business),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetailsPage(
                              project: project, index: index,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
