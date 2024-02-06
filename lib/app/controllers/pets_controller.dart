import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_app/app/models/pets_model.dart';

class PetsController extends ChangeNotifier {
  static const apiEndpoint =
      "https://jatinderji.github.io/users_pets_api/users_pets.json";

  Pets pets = Pets(data: []);
  String error = '';
  bool isLoading = true;

  Future<void> getDataFromApi() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoint));

      if (response.statusCode == 200) {
        pets = petsFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
