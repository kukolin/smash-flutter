import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/firebase_service.dart';

class RoomScreenViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService;
  late StreamSubscription? _subscription;
  Room room;

  RoomScreenViewModel(this.room, this._firebaseService);

  void onWidgetInitialize() {
    _subscription = _firebaseService.subscribe();
    _firebaseService.roomController.stream.listen((newRoom) {
      room = newRoom;
      notifyListeners();
    });
  }

  void onWidgetDestroy() {
    _subscription?.cancel();
  }
}
