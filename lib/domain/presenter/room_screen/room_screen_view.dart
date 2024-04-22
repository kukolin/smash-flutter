import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_flutter/domain/factory/viewmodel_factory.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/domain/presenter/room_screen/room_screen_view_model.dart';

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
        child: Center(child: Consumer<RoomScreenViewModel>(builder: (_, viewModel, __) => Text(viewModel.room.key))));
  }
}
