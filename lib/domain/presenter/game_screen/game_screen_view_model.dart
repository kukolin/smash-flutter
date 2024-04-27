import 'package:flutter/cupertino.dart';
import 'package:smash_flutter/domain/model/player.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/firebase_service.dart';

class GameScreenViewModel extends ChangeNotifier{

  Room room = Room.empty();
  FirebaseService firebaseService;

  GameScreenViewModel(this.firebaseService);

  void onWidgetInitialize(List<Player> initialPlayers) {
    _initializePlayers(initialPlayers);
    _subscribe();
    firebaseService.subscribe();
  }

  void _initializePlayers(List<Player> initialPlayers) {
    room.players = initialPlayers;
  }

  void _subscribe(){
    firebaseService.roomController.stream.listen((room) {
      this.room.key = room.key;
      notifyListeners();
    });
  }
}