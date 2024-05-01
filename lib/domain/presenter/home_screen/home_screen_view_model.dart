import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smash_flutter/domain/unpoquitodeinfra/repositories/in_memory_id_repository.dart';
import 'package:uuid/uuid.dart';

class HomeScreenViewModel extends ChangeNotifier{

  String roomId = "a";

  InMemoryIdRepository _myIdRepository;

  HomeScreenViewModel(this._myIdRepository);

  void onWidgetInitialize() async {
    final prefs = await SharedPreferences.getInstance();
    String myId = prefs.getString('myId') ?? await _generateIdAndSave(prefs);
    _myIdRepository.saveMyId(myId);
  }

  Future<String> _generateIdAndSave(SharedPreferences prefs) async {
    var uuid = const Uuid().v4();
    await prefs.setString('myId', uuid.substring(24));
    return uuid.substring(24);
  }
}