import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:projects_and_requirements/models/project.dart';
import 'package:projects_and_requirements/models/requirements.dart';
import 'package:projects_and_requirements/models/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  // Projects table
  static String projectsTable = 'projects';

  // Columns from projects table
  static String prjIdColumn = 'id';
  static String prjNameColumn = 'name';
  static String prjStartDateColumn = 'startDate';
  static String prjEstimatedEndDateColumn = 'estimatedEndDate';
  static String prjOwnerColumn = 'owner';

  // Requirements table
  static String requirementsTable = 'requirements';

  // Columns from requirements table
  static String reqIdColumn = 'id';
  static String reqDescriptionColumn = 'description';
  static String reqRegisterDateColumn = 'registerDate';
  static String reqImportanceColumn = 'importance';
  static String reqComplexityColumn = 'complexity';
  static String reqEstimatedTimeColumn = 'estimatedTime';
  static String reqRefProjectColumn = 'refProject';
  static String reqLocationColumn = 'location';
  static String reqImage1Column = 'image1';
  static String reqImage2Column = 'image2';
  static String reqLinkColumn = "complementInfoLink";

  // Users table
  static String usersTable = "users";

  // Columns from users table

  static String userIdColumn = 'id';
  static String userLoginColumn = 'login';
  static String userPasswordColumn = 'password';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();

    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'projects_and_requirements.db';

    var list = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return list;
  }

  void _createDatabase(Database db, int version) async {
    await db.execute('CREATE TABLE $projectsTable('
        '$prjIdColumn INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$prjNameColumn TEXT,'
        '$prjStartDateColumn TEXT,'
        '$prjEstimatedEndDateColumn TEXT,'
        '$prjOwnerColumn TEXT);');

    await db.execute('CREATE TABLE $requirementsTable('
        '$reqIdColumn INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$reqDescriptionColumn TEXT,'
        '$reqRegisterDateColumn TEXT,'
        '$reqImportanceColumn TEXT,'
        '$reqComplexityColumn TEXT,'
        '$reqEstimatedTimeColumn TEXT,'
        '$reqRefProjectColumn INTEGER,'
        '$reqLocationColumn TEXT,'
        '$reqImage1Column TEXT,'
        '$reqImage2Column TEXT,'
        '$reqLinkColumn TEXT);');

    await db.execute('CREATE TABLE $usersTable('
        '$userIdColumn INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$userLoginColumn TEXT,'
        '$userPasswordColumn TEXT);');
  }

  Future<List<Map<String, dynamic>>> getProjectsMapList() async {
    Database db = await database;
    var result = await db.rawQuery('SELECT * from $projectsTable');
    return result;
  }

  Future<int> insertProject(Project p) async {
    Database db = await database;
    var result = await db.insert(projectsTable, p.toMap());
    return result;
  }

  Future<int> deleteProject(int id) async {
    var db = await database;
    int result = await db
        .rawDelete('DELETE FROM $projectsTable WHERE $prjIdColumn = $id');
    return result;
  }

  Future<List<Project>> getProjects() async {
    var projectsMapList = await getProjectsMapList();
    int count = projectsMapList.length;
    List<Project> projects = <Project>[];
    for (int i = 0; i < count; i++) {
      projects.add(Project.fromMapObject(projectsMapList[i]));
    }
    return projects;
  }

  Future<List<Map<String, dynamic>>> getRequirementsMapList(
      int projectId) async {
    Database db = await database;
    var result = await db.rawQuery(
        'SELECT * from $requirementsTable WHERE $reqRefProjectColumn = $projectId');
    return result;
  }

  Future<int> insertRequirement(Requirement r) async {
    Database db = await database;
    var result = await db.insert(requirementsTable, r.toMap());
    return result;
  }

  Future<int> updateProject(Project p, int? id) async {
    var db = await database;
    var result = await db.rawUpdate(
      "UPDATE $projectsTable SET $prjNameColumn = '${p.name}', "
          "$prjStartDateColumn = '${p.startDate}', $prjEstimatedEndDateColumn = "
          "'${p.estimatedEndDate}', $prjOwnerColumn = '${p.owner}' WHERE $prjIdColumn = '$id'",
    );
    return result;
  }

  Future<int> updateRequirement(Requirement r, int? id) async {
    var db = await database;
    var result = await db.rawUpdate(
      "UPDATE $requirementsTable SET $reqDescriptionColumn = '${r.description}', "
      "$reqRegisterDateColumn = '${r.registerDate}', $reqImportanceColumn = "
      "'${r.importance}', $reqComplexityColumn = '${r.complexity}', $reqEstimatedTimeColumn = "
      "'${r.estimatedTime}', $reqLocationColumn = '${r.location}', $reqImage1Column = "
      "'${r.image1}', $reqImage2Column = '${r.image2}', $reqLinkColumn = '${r.complementInfoLink}' "
      "WHERE $reqIdColumn = '$id'",
    );
    return result;
  }

  Future<int> deleteRequirement(int id) async {
    var db = await database;
    int result = await db
        .rawDelete('DELETE FROM $requirementsTable WHERE $reqIdColumn = $id');
    return result;
  }

  Future<List<Requirement>> getRequirements(int projectId) async {
    var requirementsMapList = await getRequirementsMapList(projectId);
    int count = requirementsMapList.length;
    List<Requirement> requirements = <Requirement>[];
    for (int i = 0; i < count; i++) {
      requirements.add(Requirement.fromMapObject(requirementsMapList[i]));
    }
    return requirements;
  }

  Future<List<Map<String, dynamic>>> getUsersMapList() async {
    Database db = await database;
    var result = await db.rawQuery('SELECT * from $usersTable');
    return result;
  }

  Future<int> insertUser(User u) async {
    Database db = await database;
    var result = await db.insert(usersTable, u.toMap());
    return result;
  }

  Future<List<User>> getUsers() async {
    var usersMapList = await getUsersMapList();
    int count = usersMapList.length;
    List<User> users = <User>[];
    for (int i = 0; i < count; i++) {
      users.add(User.fromMapObject(usersMapList[i]));
    }
    return users;
  }
}
