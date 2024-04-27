import 'package:flutter/cupertino.dart';
import 'package:smash_flutter/firebase_service.dart';

class HomeScreenViewModel extends ChangeNotifier{

  String roomId = "a";

  FirebaseService firebaseService;

  HomeScreenViewModel(this.firebaseService);

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