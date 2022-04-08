import 'package:flutter/material.dart';
import 'package:projects_and_requirements/database/database.dart';
import 'package:projects_and_requirements/models/user.dart';
import 'package:projects_and_requirements/pages/register_page.dart';
import 'package:validatorless/validatorless.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  static DatabaseHelper? db;

  final List<User>? _users = [];

  @override
  void initState() {
    db = DatabaseHelper();

    db!.initDB();

    Future<List<User>> usersList = db!.getUsers();

    usersList.then((newUsersList) {
      setState(() {
        _users?.addAll(newUsersList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            TextFormField(
              validator: Validatorless.required("Nome de usuário obrigatório!"),
              controller: userController,
              decoration: const InputDecoration(
                icon: Icon(Icons.people),
                hintText: "Informe o seu nome de usuário",
              ),
            ),
            const Divider(),
            TextFormField(
              validator: Validatorless.multiple([
                Validatorless.required("Senha obrigatória!"),
                Validatorless.min(6, "Mínimo de 6 caracteres!")
              ]),
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.password),
                hintText: "Informe a sua senha",
              ),
            ),
            const Divider(),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  var formValid = _formKey.currentState?.validate() ?? false;
                  bool correctPassword = false;

                  if (formValid) {
                    for (User u in _users!) {
                      correctPassword = validateLogin(
                          userController.text, passwordController.text);

                      if (correctPassword) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      } else {
                        createIncorrectLoginAlertDialog(context);
                      }
                      break;
                    }
                  }
                },
                child: const Text("Entrar"),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                ),
                child: const Text('Registrar'),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateLogin(String user, String password) {
    bool result = false;

    for (User u in _users!) {
      if (u.login == user && u.password == password) {
        result = true;
        break;
      }
    }

    return result;
  }

  createIncorrectLoginAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Usuário ou senha incorretos!"),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Ok")),
          ],
        );
      },
    );
  }
}
