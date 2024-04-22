import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/firebase_service.dart';

class SearchScreenViewModel {
  final FirebaseService _firebaseService;
  SearchScreenViewModel(this._firebaseService);

  Future<void> onSubmitButton(String input, void Function(Room room) callback) async {
    var room = await _firebaseService.getRoom(input);
    if(room.key.isNotEmpty) {
      callback(room);
    }
    else {
      //TODO: Mensaje de error
    }
  }
}