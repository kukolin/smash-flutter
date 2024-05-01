import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_flutter/domain/factory/viewmodel_factory.dart';
import 'package:smash_flutter/domain/presenter/create_name_screen/create_name_screen_view_model.dart';

class CreateNameScreenView extends StatefulWidget {
  const CreateNameScreenView({super.key});

  @override
  State<CreateNameScreenView> createState() => _CreateNameScreenViewState();
}

class _CreateNameScreenViewState extends State<CreateNameScreenView> {
  late TextEditingController _controller;
  late CreateNameScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ViewModelFactory.getCreateNameScreenViewModel();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvoked: (_) => false,
        child: Center(
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
                    labelText: 'Ingrese su nombre',
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () => _viewModel.onSubmitButton(_controller.value.text, _navigateCallback),
                child: const Text("Enviar"),
              ),
              ChangeNotifierProvider(
                create: (_) => _viewModel,
                child: Consumer<CreateNameScreenViewModel>(
                  builder: (_, viewModel, __) => Text(_viewModel.errorMessage),
                ),
              )
            ],
          ),
        ));
  }

  void _navigateCallback() {
    Navigator.of(context).pop();
  }
}
