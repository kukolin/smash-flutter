import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_flutter/domain/factory/viewmodel_factory.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/domain/presenter/game_screen/game_screen_view.dart';
import 'package:smash_flutter/domain/presenter/room_screen/room_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/utils/view_utils.dart';

class RoomScreenView extends StatefulWidget {
  final Room foundRoom;

  const RoomScreenView(this.foundRoom, {super.key});

  @override
  State<RoomScreenView> createState() => _RoomScreenViewState();
}

class _RoomScreenViewState extends State<RoomScreenView> {
  late final RoomScreenViewModel _viewModel;

  @override
  void initState() {
    _viewModel = ViewModelFactory.getRoomScreenViewModel(widget.foundRoom);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _viewModel,
        child: Center(
            child: Consumer<RoomScreenViewModel>(
                builder: (_, viewModel, __) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Gente en la sala: ${_viewModel.room.players.length}/4",
                          style: const TextStyle(fontSize: 25),
                        ),
                        buildPlayersColumn(),
                        _space(),
                        const Text("ID de sala", style: TextStyle(fontSize: 25)),
                        Text(_viewModel.room.key, style: const TextStyle(fontSize: 20)),
                        _space(),
                        RedirectButton("Iniciar partida", GameScreenView(_viewModel.room.players))
                      ],
                    ))));
  }

  SizedBox _space() => const SizedBox(height: 60);

  Column buildPlayersColumn() {
    return Column(
      children: _viewModel.room.players.map((e) => Text(e.name, style: const TextStyle(fontSize: 20))).toList(),
    );
  }
}
