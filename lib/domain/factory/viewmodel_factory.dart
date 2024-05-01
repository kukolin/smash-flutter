import 'package:smash_flutter/domain/factory/service_factory.dart';
import 'package:smash_flutter/domain/model/player.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/domain/presenter/game_screen/game_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/home_screen/home_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/room_screen/room_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/search_screen/search_screen_view_model.dart';
import 'package:smash_flutter/domain/unpoquitodeinfra/repositories/in_memory_id_repository.dart';

class ViewModelFactory {
  static final InMemoryIdRepository _idRepository = InMemoryIdRepository();

  static HomeScreenViewModel getHomePageViewModel() => HomeScreenViewModel(_idRepository);

  static SearchScreenViewModel getSearchScreenViewModel() => SearchScreenViewModel(ServiceFactory.getFirebaseService(), _idRepository);

  static GameScreenViewModel getGameScreenViewModel() => GameScreenViewModel(ServiceFactory.getFirebaseService());

  static RoomScreenViewModel getRoomScreenViewModel(Room room) =>
      RoomScreenViewModel(room, ServiceFactory.getFirebaseService());
}
