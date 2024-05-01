import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smash_flutter/domain/unpoquitodeinfra/repositories/in_memory_id_repository.dart';

class CreateNameScreenViewModel extends ChangeNotifier{
  String errorMessage = "";
  final InMemoryUserRepository _userDataRepository;

  CreateNameScreenViewModel(this._userDataRepository);

  onSubmitButton(String text, void Function() navigateCallback) async {
    final prefs = await SharedPreferences.getInstance();
    errorMessage = "";
    if(text.length > 15) {
      errorMessage = "Máximo 15 caracteres.";
      notifyListeners();
      return;
    }
    var validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
    if(!validCharacters.hasMatch(text)) {
      errorMessage = "Sólo caracteres alfanuméricos.";
      notifyListeners();
      return;
    }
    prefs.setString("myName", text);
    _userDataRepository.saveMyName(text);
    navigateCallback();
  }
}