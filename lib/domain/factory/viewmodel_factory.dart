import 'package:smash_flutter/domain/factory/service_factory.dart';
import 'package:smash_flutter/domain/presenter/home_page/home_page_view_model.dart';

class ViewModelFactory {
  static HomePageViewModel getHomePageViewModel() => HomePageViewModel(ServiceFactory.getFirebaseService());
}
