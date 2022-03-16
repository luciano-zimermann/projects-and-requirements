import 'package:flutter/material.dart';
import 'package:projects_and_requirements/pages/project_details_page.dart';

class ProjectsListPage extends StatefulWidget {
  const ProjectsListPage({Key? key}) : super(key: key);

  @override
  State<ProjectsListPage> createState() => _ProjectsListPageState();
}

class _ProjectsListPageState extends State<ProjectsListPage> {
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
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Card(
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Text(
                    'Nome do Projeto - ${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                subtitle: const Text('Responsável: Fulano Silveira'),
                trailing: const Icon(Icons.business),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProjectDetailsPage(),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
