import 'dart:convert';

import 'package:covid_tracker/Models/Services/Utlites/app_url.dart';
import 'package:covid_tracker/Models/world_model_api.dart';
import 'package:http/http.dart' as http;

class StateService {
  Future<WorldStatesModel> fecthWorkStatesRecords() async {
    final responese = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (responese.statusCode == 200) {
      var data = jsonDecode(responese.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }
}
