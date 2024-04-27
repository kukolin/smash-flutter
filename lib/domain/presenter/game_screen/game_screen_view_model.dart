import 'package:flutter/cupertino.dart';
import 'package:smash_flutter/firebase_service.dart';

class GameScreenViewModel extends ChangeNotifier{

  String roomId = "a";

  FirebaseService firebaseService;

  GameScreenViewModel(this.firebaseService);

  void onWidgetInitialize() {
    _subscribe();
    firebaseService.subscribe();
  }

  void _subscribe(){
    firebaseService.roomController.stream.listen((room) {
      roomId = room.key;
      notifyListeners();
    });
  }
}