// lib/services/json_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../../data/model/user_model.dart';

class JsonService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _userFile async {
    final path = await _localPath;
    return File('$path/datauser.json');
  }

  Future<List<UserModel>> readUsers() async {
    try {
      final file = await _userFile;
      if (!await file.exists()) {
        await file.writeAsString(json.encode({"users": []}));
        return [];
      }

      final String contents = await file.readAsString();
      final data = json.decode(contents);
      List<UserModel> users = (data['users'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
      return users;
    } catch (e) {
      print('Error reading users: $e');
      return [];
    }
  }

  Future<bool> writeUsers(List<UserModel> users) async {
    try {
      final file = await _userFile;
      await file.writeAsString(json.encode({
        "users": users.map((user) => user.toJson()).toList(),
      }));
      return true;
    } catch (e) {
      print('Error writing users: $e');
      return false;
    }
  }

  Future<bool> addUser(UserModel newUser) async {
    try {
      final users = await readUsers();
      if (users.any((user) => user.email == newUser.email)) {
        return false; // Email already exists
      }
      users.add(newUser);
      return await writeUsers(users);
    } catch (e) {
      print('Error adding user: $e');
      return false;
    }
  }
}
