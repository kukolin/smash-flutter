import 'package:flutter/material.dart';
import 'package:smash_flutter/domain/factory/viewmodel_factory.dart';
import 'package:smash_flutter/domain/presenter/create_name_screen/create_name_screen_view.dart';
import 'package:smash_flutter/domain/presenter/home_screen/home_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/search_screen/search_screen_view.dart';
import 'package:smash_flutter/domain/presenter/utils/view_utils.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final HomeScreenViewModel _viewModel = ViewModelFactory.getHomePageViewModel();

  @override
  void initState() {
    _viewModel.onWidgetInitialize(_navigateCallback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RedirectButton("Buscar sala", SearchScreenView()),
            SizedBox(height: 20,),
            RedirectButton("Crear sala", SearchScreenView()),
            SizedBox(height: 50,),
          ]),
    );
  }

  void _navigateCallback() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Scaffold(body: CreateNameScreenView()),
      ),
    );
  }
}
