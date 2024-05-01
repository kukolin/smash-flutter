import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smash_flutter/firebase_service.dart';
import 'package:uuid/uuid.dart';

class HomeScreenViewModel extends ChangeNotifier{

  String roomId = "a";

  FirebaseService firebaseService;

  HomeScreenViewModel(this.firebaseService);

  void onWidgetInitialize() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString('myId') ?? _generateIdAndSave(prefs);
  }

  _generateIdAndSave(SharedPreferences prefs) async {
    var uuid = const Uuid().v4();
    debugPrint("creado id: ${uuid.substring(24)}");
    await prefs.setString('myId', uuid.substring(24));
  }
}