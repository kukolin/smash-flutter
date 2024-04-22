import 'package:smash_flutter/domain/factory/service_factory.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/domain/presenter/home_page/home_page_view_model.dart';
import 'package:smash_flutter/domain/presenter/room_screen/room_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/search_screen_view/search_screen_view_model.dart';

class ViewModelFactory {
  static HomePageViewModel getHomePageViewModel() => HomePageViewModel(ServiceFactory.getFirebaseService());

  static SearchScreenViewModel getSearchScreenViewModel() => SearchScreenViewModel(ServiceFactory.getFirebaseService());

  static RoomScreenViewModel getRoomScreenViewModel(Room room) =>
      RoomScreenViewModel(room, ServiceFactory.getFirebaseService());
}
