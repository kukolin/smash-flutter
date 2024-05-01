import 'package:flutter/material.dart';

class RedirectButton extends StatelessWidget {
  final String text;
  final Widget screen;
  final bool enabled;
  final void Function()? _extraBehaviour;

  const RedirectButton(
      this.text,
      this.screen,
      {
        this.enabled = true,
        void Function()? extraBehaviour,
        super.key,
      }) : _extraBehaviour = extraBehaviour;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? () => onButtonPressed(context) : null,
      child: Text(text, style: const TextStyle(fontSize: 20)),
    );
  }

  dynamic onButtonPressed(BuildContext context) {
    if(_extraBehaviour != null) {
      _extraBehaviour();
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(body: screen),
      ),
    );
  }
}


// child: ChangeNotifierProvider(
//     create: (_) => _viewModel,
//     child: Consumer<HomePageViewModel>(builder: (_, viewModel, __) => Text(viewModel.roomId))));