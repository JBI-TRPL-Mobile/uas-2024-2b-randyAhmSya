import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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

  static Future<void> writeUsers(List<dynamic> users) async {
    final file = await _userFile;
    await file.writeAsString(json.encode({"users": users}));
  }
}
