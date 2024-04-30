import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:smash_flutter/domain/model/room_dto.dart';

import 'domain/model/room.dart';

class FirebaseService {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('rooms');

  StreamController<Room> roomController = StreamController<Room>();

  DatabaseReference getRoomRef(String roomId) {
    return ref.child(roomId).child("room");
  }

  StreamSubscription<DatabaseEvent> initializeDatabaseForRoom(String roomId) {
    return ref.child(roomId).child("room").onValue.listen((event) {
      roomController.add(_snapshotToRoom(event.snapshot.value));
    });
  }

  Future<Room> getRoom(String roomId) async {
    final snapshot = await ref.child(roomId).child("room").get();
    if (snapshot.exists) {
      return _snapshotToRoom(snapshot.value);
    } else {
      return Room.empty();
    }
  }

  Room _snapshotToRoom(Object? snapshot) {
    Map<dynamic, dynamic> roomAsMap = snapshot as dynamic;
    Map<String, dynamic> roomAsStringMap = {};
    roomAsMap.forEach((key, value) {
      roomAsStringMap[key.toString()] = value;
    });
    return Room.fromDTO(RoomDTO.fromJson(roomAsStringMap));
  }

  void saveRoomData(Room room) {
    ref.child(room.key).child("room").update(RoomDTO.fromRoom(room).toJson());
  }
}
