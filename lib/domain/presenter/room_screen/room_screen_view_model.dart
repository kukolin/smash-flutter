import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/domain/unpoquitodeinfra/repositories/in_memory_id_repository.dart';
import 'package:smash_flutter/firebase_service.dart';

class RoomScreenViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService;
  final List<StreamSubscription> _disposeBag = [];
  final InMemoryUserRepository _userDataRepository;

  Room room;

  RoomScreenViewModel(this.room, this._firebaseService, this._userDataRepository);

  void onWidgetInitialize() {
    var subscription2 = _firebaseService.initializeDatabaseForRoom(room.key);
    var subscription1 = _firebaseService.roomController.stream.listen((newRoom) {
      room = newRoom;
      notifyListeners();
    });
    _disposeBag.add(subscription1);
    _disposeBag.add(subscription2);
  }

  void onWidgetDestroy() {
    for (var element in _disposeBag) {
      element.cancel();
    }
  }

  void shuffleAndAssignCard() {
    List<int> cards = [];
    for (var i = 1; i <= 4; i++) {
      for (var j = 1; j <= 15; j++) {
        cards.add(j);
      }
    }
    cards.shuffle(Random());
    var chunkSize = cards.length / room.players.length;
    var cardsToGive = cards.slices(chunkSize.toInt()).toList();
    for (final (index, player) in room.players.indexed) {
      player.cards = cardsToGive[index];
    }
    room.started = true;
    _firebaseService.saveRoomData(room);
  }

  bool startButtonEnabled() {
    var me = room.players.firstWhereOrNull((element) => element.id == _userDataRepository.getMyId());
    return me?.isOwner ?? false;
  }
}
