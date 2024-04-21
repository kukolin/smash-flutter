import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_flutter/domain/factory/viewmodel_factory.dart';
import 'package:smash_flutter/domain/presenter/home_page/home_page_view_model.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  final HomePageViewModel _viewModel = ViewModelFactory.getHomePageViewModel();

  @override
  void initState() {
    _viewModel.onWidgetInitialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ChangeNotifierProvider(
            create: (_) => _viewModel,
            child: Consumer<HomePageViewModel>(builder: (_, viewModel, __) => Text(viewModel.roomId))));
  }
}
