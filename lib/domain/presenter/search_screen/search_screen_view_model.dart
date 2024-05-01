import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:smash_flutter/domain/model/player.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/domain/unpoquitodeinfra/repositories/in_memory_id_repository.dart';
import 'package:smash_flutter/firebase_service.dart';

class SearchScreenViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService;
  final InMemoryUserRepository _userDataRepository;
  String errorMessage = "";

  SearchScreenViewModel(this._firebaseService, this._userDataRepository);

  Future<void> onSubmitButton(String input, void Function(Room room) redirectCallback) async {
    errorMessage = "";
    var room = await _firebaseService.getRoom(input);
    _checkIfRoomExists(room);
    _checkIfRoomIsFull(room);
    _checkIfImJoined(room);
    if (errorMessage.isEmpty) {
      redirectCallback(room);
    }
  }

  void _checkIfRoomIsFull(Room room) {
    if (room.players.length >= 4) {
      errorMessage = "Sala llena. Máximo 4 jugadores.";
      notifyListeners();
    }
  }

  void _checkIfRoomExists(Room room) {
    if (room.key.isEmpty) {
      errorMessage = "No se encuentra la sala.";
      notifyListeners();
    }
  }

  void _checkIfImJoined(Room room) {
    var foundPlayer = room.players.firstWhereOrNull((element) => element.id == _userDataRepository.getMyId());
    if (foundPlayer == null && room.players.length < 4) {
      _addMeToDatabase(room);
    } else {
      errorMessage = "";
      notifyListeners();
    }
  }

  void _addMeToDatabase(Room room) {
    var me = Player(_userDataRepository.getMyId(), _userDataRepository.getMyName(), [], false);
    room.players.add(me);
    _firebaseService.saveRoomData(room);
  }
}
