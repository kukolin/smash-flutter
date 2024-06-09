import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_flutter/domain/factory/viewmodel_factory.dart';
import 'package:smash_flutter/domain/model/player.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/domain/presenter/game_screen/game_screen_view_model.dart';

class GameScreenView extends StatefulWidget {
  final Room initialRoom;

  const GameScreenView(this.initialRoom, {super.key});

  @override
  State<GameScreenView> createState() => _GameScreenViewState();
}

class _GameScreenViewState extends State<GameScreenView> {
  final GameScreenViewModel _viewModel = ViewModelFactory.getGameScreenViewModel();

  @override
  void initState() {
    _viewModel.onWidgetInitialize(widget.initialRoom);
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.onWidgetDestroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _viewModel,
        child: Consumer<GameScreenViewModel>(
          builder: (_, __, ___) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              _buildBody(),
              _buildFooter(),
            ],
          ),
        ));
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _viewModel.getOpponents().map((e) => _buildOpponentInfo(e)).toList(),
          ),
          const Divider(color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(_viewModel.room.cardStack.lastOrNull?.toString() ?? "", style: const TextStyle(fontSize: 50)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Divider(color: Colors.black),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Center(
                        child: Text("Tus cartas: ${_viewModel.getMyCardQuantity()}",
                            style: const TextStyle(fontSize: 25)))),
                const VerticalDivider(
                  color: Colors.black,
                  width: 2,
                ),
                Expanded(
                    child: Center(
                        child: Text("Turno n°: ${_viewModel.getTurnNumber()}", style: const TextStyle(fontSize: 25)))),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ElevatedButton(
                onPressed: _viewModel.isMyTurn() ? _viewModel.onDrawCardTaped : null,
                style: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(60)),
                child: const Text(
                  "Tirar carta",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
        ],
      ),
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
