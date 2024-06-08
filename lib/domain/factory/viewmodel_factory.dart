import 'package:smash_flutter/domain/factory/service_factory.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/domain/presenter/create_name_screen/create_name_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/game_screen/game_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/home_screen/home_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/room_screen/room_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/search_screen/search_screen_view_model.dart';
import 'package:smash_flutter/domain/unpoquitodeinfra/repositories/in_memory_id_repository.dart';

class ViewModelFactory {
  static final InMemoryUserRepository _userDataRepository = InMemoryUserRepository();

  static HomeScreenViewModel getHomePageViewModel() => HomeScreenViewModel(ServiceFactory.getFirebaseService(), _userDataRepository);

  static SearchScreenViewModel getSearchScreenViewModel() => SearchScreenViewModel(ServiceFactory.getFirebaseService(), _userDataRepository);

  static GameScreenViewModel getGameScreenViewModel() => GameScreenViewModel(ServiceFactory.getFirebaseService(), _userDataRepository);

  static RoomScreenViewModel getRoomScreenViewModel(Room room, void Function() redirectCallback) =>
      RoomScreenViewModel(room, ServiceFactory.getFirebaseService(), _userDataRepository, redirectCallback);

  static CreateNameScreenViewModel getCreateNameScreenViewModel() => CreateNameScreenViewModel(_userDataRepository);
}
