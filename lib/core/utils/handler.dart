import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../data/model/user_model.dart';

class FileHandler {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _userFile async {
    final path = await _localPath;
    return File('$path/datauser.json');
  }

  static Future<List<dynamic>> readUsers() async {
    try {
      final file = await _userFile;
      if (!await file.exists()) {
        await file.writeAsString(json.encode({"users": []}));
        return [];
      }
      final contents = await file.readAsString();
      final data = json.decode(contents);
      return data['users'];
    } catch (e) {
      return [];
    }
  }

  static Future<void> writeUsers(List<UserModel> users) async {
    final file = await _userFile;
    final usersToJson = users.map((user) => user.toJson()).toList();
    await file.writeAsString(jsonEncode({"users": usersToJson}));
  }
}
