import 'package:flutter/material.dart';
import 'package:projects_and_requirements/pages/project_page.dart';
import 'package:projects_and_requirements/pages/projects_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 30),
        child: Column(
          children: [
            const Text(
              'Bem-vindo ao Requereasy Tech!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Colors.green,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Soluções simples para o gerenciamento de Projetos e seus Requisitos, bem na sua mão!',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                right: 30,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProjectPage(),
                    ),
                  );
                },
                child: const Text(
                  'Cadastrar Projeto',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(450, 150),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                right: 30,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProjectsListPage(),
                    ),
                  );
                },
                child: const Text(
                  'Listar Projetos',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(450, 150),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: const Text(
          "Todos os Direitos Reservados - 2022©",
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
