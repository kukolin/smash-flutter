import 'package:flutter/material.dart';

class RedirectButton extends StatelessWidget {
  final String text;
  final Widget screen;
  final void Function()? _extraBehaviour;

  const RedirectButton(
      this.text,
      this.screen,
      {
        void Function()? extraBehaviour,
        super.key,
      }) : _extraBehaviour = extraBehaviour;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if(_extraBehaviour != null) {
          _extraBehaviour();
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(body: screen),
          ),
        );
      },
      child: Text(text, style: const TextStyle(fontSize: 20)),
    );
  }

  void asd() {

  }
}


// child: ChangeNotifierProvider(
//     create: (_) => _viewModel,
//     child: Consumer<HomePageViewModel>(builder: (_, viewModel, __) => Text(viewModel.roomId))));