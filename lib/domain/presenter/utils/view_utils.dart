import 'package:flutter/material.dart';

class RedirectButton extends StatelessWidget {
  final String text;
  final Widget screen;

  const RedirectButton(
      this.text,
      this.screen, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(body: screen),
        ),
      ),
      child: Text(text, style: const TextStyle(fontSize: 20)),
    );
  }
}


// child: ChangeNotifierProvider(
//     create: (_) => _viewModel,
//     child: Consumer<HomePageViewModel>(builder: (_, viewModel, __) => Text(viewModel.roomId))));