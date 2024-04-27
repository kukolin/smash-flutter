import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/firebase_service.dart';

class GameScreenViewModel extends ChangeNotifier {

  Room room = Room.empty();
  FirebaseService firebaseService;

  GameScreenViewModel(this.firebaseService);

  void onWidgetInitialize(Room initialRoom) {
    _initializeRoom(initialRoom);
    _subscribe();
    _initializeDatabaseForRoom(initialRoom);
  }

  void _initializeRoom(Room initialRoom) {
    room = initialRoom;
  }

  void _subscribe() {
    firebaseService.roomController.stream.listen((room) {
      this.room.key = room.key;
      notifyListeners();
    });
  }

  StreamSubscription<DatabaseEvent> _initializeDatabaseForRoom(Room initialRoom) =>
      firebaseService.initializeDatabaseForRoom(initialRoom.key);
}
