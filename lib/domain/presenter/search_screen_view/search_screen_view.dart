import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smash_flutter/domain/factory/viewmodel_factory.dart';
import 'package:smash_flutter/domain/presenter/room_screen/room_screen_view.dart';
import 'package:smash_flutter/domain/presenter/search_screen_view/search_screen_view_model.dart';

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
          ElevatedButton(
            onPressed: () =>
                _viewModel.onSubmitButton(
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Scaffold(body: RoomScreenView()),
                      ),
                    )), child: const Text("Buscar"),),
        ],
      ),
    );
  }
}
