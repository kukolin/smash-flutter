import 'package:flutter/material.dart';
import 'package:smash_flutter/domain/factory/viewmodel_factory.dart';
import 'package:smash_flutter/domain/model/player.dart';
import 'package:smash_flutter/domain/presenter/game_screen/game_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/home_screen/home_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/search_screen/search_screen_view.dart';

class GameScreenView extends StatefulWidget {
  final List<Player> initialPlayers;

  const GameScreenView(this.initialPlayers, {super.key});

  @override
  State<GameScreenView> createState() => _GameScreenViewState();
}

class _GameScreenViewState extends State<GameScreenView> {
  final GameScreenViewModel _viewModel = ViewModelFactory.getGameScreenViewModel();

  @override
  void initState() {
    _viewModel.onWidgetInitialize(widget.initialPlayers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeader(),
        _buildBody(),
        _buildCardButton(),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _viewModel.room.players.map((e) => _buildOpponentInfo(e)).toList(),
      ),
    );
  }

  Center _buildCardButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(60)),
          child: const Text(
            "Tirar carta",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text("0", style: TextStyle(fontSize: 50)),
      ],
    );
  }

  Widget _buildOpponentInfo(Player player) {
    return Column(
      children: [
        const Image(image: AssetImage('assets/images/avataricon.png'), height: 60, width: 60),
        Text(player.name, style: const TextStyle(fontSize: 25)),
        Text("cards: ${player.cards.length}", style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}
