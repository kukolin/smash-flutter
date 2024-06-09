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

  List<StreamSubscription> subscriptions = [];

  GameScreenViewModel(this.firebaseService, this._userDataRepository);

  void onWidgetInitialize(Room initialRoom) {
    _initializeRoom(initialRoom);
    _initializeDatabaseForRoom(initialRoom);
    _subscribe();
  }

  void _initializeRoom(Room initialRoom) {
    room = initialRoom;
  }

  void _subscribe() {
    var sus = firebaseService.roomController.stream.listen((newRoom) {
      room = newRoom;
      notifyListeners();
    });
    subscriptions.add(sus);
  }

  void onWidgetDestroy() {
    for (var element in subscriptions) {
      element.cancel();
    }
    subscriptions.clear();
  }

  void _initializeDatabaseForRoom(Room initialRoom) {
    var sus = firebaseService.initializeDatabaseForRoom(initialRoom.key);
    subscriptions.add(sus);
  }

  List<Player> getOpponents() {
    return room.players.where((p) => p.id != _userDataRepository.getMyId()).toList();
  }

  Player? getMe() => room.players.firstWhereOrNull((p) => p.id != _userDataRepository.getMyId());

  int getMyCardQuantity() {
    return getMe()?.cards.length ?? 0;
  }

  int getTurnNumber() {
    return room.cardStack.length % 15;
  }

  bool isMyTurn() {
    debugPrint(room.currentTurn);
    debugPrint(_userDataRepository.getMyId());
    return room.currentTurn == _userDataRepository.getMyId();
  }

  void onDrawCardTaped() {
    room.currentTurn = "";
    notifyListeners();
    var orderedPlayers = room.players.sortedBy((element) => element.id);
    var myIndex = orderedPlayers.indexWhere((p) => p.id == _userDataRepository.getMyId());
    if (orderedPlayers.length == myIndex + 1) {
      room.currentTurn = orderedPlayers[0].id;
    } else {
      room.currentTurn = orderedPlayers[myIndex + 1].id;
    }
    firebaseService.saveRoomData(room);
  }
}
