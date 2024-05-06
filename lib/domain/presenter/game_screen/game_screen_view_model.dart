import 'dart:async';

import 'package:collection/collection.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smash_flutter/domain/model/player.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/domain/unpoquitodeinfra/repositories/in_memory_id_repository.dart';
import 'package:smash_flutter/firebase_service.dart';

class GameScreenViewModel extends ChangeNotifier {

  Room room = Room.empty();
  FirebaseService firebaseService;

  final InMemoryUserRepository _userDataRepository;

  bool get isDrawCardEnabled => _isDrawCardEnabled;
  bool _isDrawCardEnabled = false;

  GameScreenViewModel(this.firebaseService, this._userDataRepository);

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

  List<Player> getOpponents() => room.players.takeWhile((p) => p.id != _userDataRepository.getMyId()).toList();

  Player? getMe() => room.players.firstWhereOrNull((p) => p.id != _userDataRepository.getMyId());

  int getMyCardQuantity() {
    return getMe()?.cards.length ?? 0;
  }

  int getTurnNumber() {
    return room.cardStack.length % 15;
  }

  void onDrawCardTaped() {
    _isDrawCardEnabled = false;
    notifyListeners();
    var orderedPlayers = room.players.sortedBy((element) => element.id);
    var myIndex = orderedPlayers.indexWhere((p) => p.id == _userDataRepository.getMyId());
    if(orderedPlayers.length == myIndex + 1) {
      room.currentTurn = orderedPlayers[0].id;
    } else {
      room.currentTurn = orderedPlayers[myIndex + 1].id;
    }
    firebaseService.saveRoomData(room);
  }
}
