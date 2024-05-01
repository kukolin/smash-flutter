import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_flutter/domain/factory/viewmodel_factory.dart';
import 'package:smash_flutter/domain/model/room.dart';
import 'package:smash_flutter/domain/presenter/room_screen/room_screen_view.dart';
import 'package:smash_flutter/domain/presenter/search_screen/search_screen_view_model.dart';

class SearchScreenView extends StatefulWidget {
  const SearchScreenView({super.key});

  @override
  State<SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<SearchScreenView> {
  late TextEditingController _controller;
  late SearchScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ViewModelFactory.getSearchScreenViewModel();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ID de sala',
              ),
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () => _viewModel.onSubmitButton(_controller.value.text, (Room room) => _navigateCallback(room)),
            child: const Text("Buscar"),
          ),
          ChangeNotifierProvider(
            create: (_) => _viewModel,
            child: Consumer<SearchScreenViewModel>(
              builder: (_, viewModel, __) => Text(_viewModel.errorMessage),
            ),
          )
        ],
      ),
    );
  }

  void _navigateCallback(Room room) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(body: RoomScreenView(room)),
      ),
    );
  }
}
