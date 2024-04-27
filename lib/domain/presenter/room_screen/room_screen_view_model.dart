import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/firebase_service.dart';

class RoomScreenViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService;
  final List<StreamSubscription> _disposeBag = [];
  Room room;

  RoomScreenViewModel(this.room, this._firebaseService);

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
    for (var element in _disposeBag) { element.cancel();}
  }
}
