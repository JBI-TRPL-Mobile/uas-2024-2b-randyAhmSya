import 'package:flutter/material.dart';

import '../../../data/model/messege.dart';

class ChatProvider with ChangeNotifier {
  List<Messegemodel> _messages = [];
  bool _isLoading = false;

  List<Messegemodel> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> loadMessages() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Load from local JSON file
      // Implementation needed for actual file reading
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  void sendMessage(Messegemodel message) {
    _messages.add(message);
    notifyListeners();
  }
}
