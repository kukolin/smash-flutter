import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_flutter/domain/factory/viewmodel_factory.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/domain/presenter/create_name_screen/create_name_screen_view.dart';
import 'package:smash_flutter/domain/presenter/home_screen/home_screen_view_model.dart';
import 'package:smash_flutter/domain/presenter/room_screen/room_screen_view.dart';
import 'package:smash_flutter/domain/presenter/search_screen/search_screen_view.dart';
import 'package:smash_flutter/domain/presenter/utils/view_utils.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> with RouteAware {
  final HomeScreenViewModel _viewModel = ViewModelFactory.getHomePageViewModel();

  @override
  void initState() {
    _viewModel.onWidgetInitialize(_navigateCallback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _viewModel.onNameEditTap(_navigateCallback),
          child: Row(
            children: [
              ChangeNotifierProvider(
                create: (_) => _viewModel,
                child: Consumer<HomeScreenViewModel>(
                  builder: (_, viewModel, __) =>
                      Text("Usuario: ${_viewModel.myName}", style: const TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.mode_edit,
              ),
            ],
          ),
        ),
        Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const RedirectButton("Buscar sala", SearchScreenView()),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => _viewModel.onCreateButtonPressed(_navigateToRoomCallback),
                  child: const Text("Crear sala", style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(
                  height: 50,
                ),
              ]),
        ),
      ],
    );
  }

  Future<void> _navigateCallback({bool allowBack = false}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(body: CreateNameScreenView(allowBack: allowBack)),
      ),
    );
  }

  Future<void> _navigateToRoomCallback(Room room) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(body: RoomScreenView(room)),
      ),
    );
  }
}
