import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:smash_flutter/domain/model/room_dto.dart';

import 'domain/model/room.dart';

class FirebaseFactory {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('rooms');

  StreamController<Room> roomController = StreamController<Room>();

  DatabaseReference getRoomRef(String roomId) {
    return ref.child(roomId).child("room");
  }
  
  void subscribe() {
    ref.child("SMPHWH").child("room").onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      Map<dynamic, dynamic> asd = dataSnapshot.value as dynamic;
      Map<String, dynamic> asd2 = {};
      asd.forEach((key, value) {
        asd2[key.toString()] = value;
      });
      RoomDTO asd3 = RoomDTO.fromJson(asd2);
      roomController.add(Room.fromDTO(RoomDTO.fromJson(asd2)));
      print(asd3.key);
    });
  }
}
