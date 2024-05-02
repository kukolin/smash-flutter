import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smash_flutter/domain/model/player.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/domain/unpoquitodeinfra/repositories/in_memory_id_repository.dart';
import 'package:smash_flutter/firebase_service.dart';
import 'package:uuid/uuid.dart';

class HomeScreenViewModel extends ChangeNotifier{

  String roomId = "a";
  String myName = "";

  final InMemoryUserRepository _userDataRepository;
  final FirebaseService _firebaseRepository;

  HomeScreenViewModel(this._firebaseRepository, this._userDataRepository);

  void onWidgetInitialize(void Function() navigateCreateNameCallback) async {
    final prefs = await SharedPreferences.getInstance();
    String myId = prefs.getString('myId') ?? await _generateIdAndSave(prefs);
    _userDataRepository.saveMyId(myId);
    String? myName = prefs.getString('myName');
    if(myName == null) {
      navigateCreateNameCallback();
    } else {
      this.myName = myName;
      notifyListeners();
      _userDataRepository.saveMyName(myName);
    }
  }

  Future<String> _generateIdAndSave(SharedPreferences prefs) async {
    var uuid = const Uuid().v4();
    await prefs.setString('myId', uuid.substring(24));
    return uuid.substring(24);
  }

  void onNameEditTap(Future<void> Function({bool allowBack}) navigateCreateNameCallback) async {
    await navigateCreateNameCallback(allowBack: true);
    _updateName();
  }

  void _updateName() {
    myName = _userDataRepository.getMyName();
    notifyListeners();
  }

  void onCreateButtonPressed(Future<void> Function(Room room) navigateToRoomCallback) {
    var key = _generateRandomString(6);
    var me = Player(_userDataRepository.getMyId(), _userDataRepository.getMyName(), [], true);
    var newRoom = Room([], _userDataRepository.getMyId(), key, "sala", [me], false);
    _firebaseRepository.saveRoomData(newRoom);
    navigateToRoomCallback(newRoom);
  }

  String _generateRandomString(int length) {
    Random random = Random();
    String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    String result = '';
    for (int i = 0; i < length; i++) {
      result += letters[random.nextInt(letters.length)];
    }
    return result;
  }
}