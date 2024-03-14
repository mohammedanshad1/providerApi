import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;

import 'model.dart';

class ModelsProvider extends ChangeNotifier {
  static const apiEndpoint =
      "https://reqres.in/api/users?page=2";

  bool isLoading = true;
  String error = '';
  Models models = Models(data: []);
  Models serachedModels = Models(data: []);
  String searchText = '';

  //
  getDataFromAPI() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        models = modelsFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    updateData();
  }

  updateData() {
    serachedModels.data!.clear();
    if (searchText.isEmpty) {
      serachedModels.data!.addAll(models.data!);
    } else {
      serachedModels.data!.addAll(models.data!
          .where((element) =>
          element.firstName!.toLowerCase().startsWith(searchText))
          .toList());
    }
    notifyListeners();
  }

  search(String username) {
    searchText = username;
    updateData();
  }
//
}
