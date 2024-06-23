import 'dart:async';

import 'package:collection/collection.dart';
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

  bool _gameEnded = false;
  bool get gameEnded => _gameEnded;

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
    if(_checkWinConditions()) {
      _handleIWon();
      return;
    }
    _advanceTurn();
    _addCardToStack();
    _dropThatCard();
    firebaseService.saveRoomData(room);
  }

  void _advanceTurn() {
    var orderedPlayers = _getPlayersSorted();
    var myIndex = orderedPlayers.indexWhere((p) => p.id == _userDataRepository.getMyId());
    if (orderedPlayers.length == myIndex + 1) {
      room.currentTurn = orderedPlayers[0].id;
    } else {
      room.currentTurn = orderedPlayers[myIndex + 1].id;
    }
  }

  void _addCardToStack() {
    final lastCard = room.players.firstWhereOrNull((p) => p.id != _userDataRepository.getMyId())!.cards.last;
    room.cardStack.add(lastCard);
  }

  void _dropThatCard() {
    room.players.firstWhereOrNull((p) => p.id != _userDataRepository.getMyId())!.cards.removeLast();
  }

  List<Player> _getPlayersSorted() => room.players.sortedBy((element) => element.id);

  bool _checkWinConditions() => getMyCardQuantity() <= 1;

  void _handleIWon() {
    _gameEnded = true;
  }
}
