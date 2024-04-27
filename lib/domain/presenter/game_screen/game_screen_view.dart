import 'package:flutter/material.dart';
import 'package:smash_flutter/domain/factory/viewmodel_factory.dart';
import 'package:smash_flutter/domain/presenter/game_screen/game_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/home_screen/home_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/search_screen/search_screen_view.dart';

class GameScreenView extends StatefulWidget {
  const GameScreenView({super.key});

  @override
  State<GameScreenView> createState() => _GameScreenViewState();
}

class _GameScreenViewState extends State<GameScreenView> {
  final GameScreenViewModel _viewModel = ViewModelFactory.getGameScreenViewModel();

  @override
  void initState() {
    _viewModel.onWidgetInitialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("asd")
      ],
    );
  }
}
