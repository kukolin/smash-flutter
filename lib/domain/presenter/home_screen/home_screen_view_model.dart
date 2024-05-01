import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smash_flutter/domain/unpoquitodeinfra/repositories/in_memory_id_repository.dart';
import 'package:uuid/uuid.dart';

class HomeScreenViewModel extends ChangeNotifier{

  String roomId = "a";

  final InMemoryUserRepository _userDataRepository;

  HomeScreenViewModel(this._userDataRepository);

  void onWidgetInitialize(void Function() navigateCreateNameCallback) async {
    final prefs = await SharedPreferences.getInstance();
    String myId = prefs.getString('myId') ?? await _generateIdAndSave(prefs);
    _userDataRepository.saveMyId(myId);
    String? myName = prefs.getString('myName');
    if(myName == null) {
      navigateCreateNameCallback();
    } else {
      _userDataRepository.saveMyName(myName);
    }
  }

  Future<String> _generateIdAndSave(SharedPreferences prefs) async {
    var uuid = const Uuid().v4();
    await prefs.setString('myId', uuid.substring(24));
    return uuid.substring(24);
  }
}