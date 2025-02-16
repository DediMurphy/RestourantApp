import 'package:flutter/cupertino.dart';
import 'package:restourantapp/data/api_service.dart';
import 'package:restourantapp/static/tourism_detail_result_state.dart';

class TourismDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  TourismDetailProvider(this._apiServices);

  TourismDetailResultState _resultState = TourismDetailNoneState();

  TourismDetailResultState get resultState => _resultState;

  Future<void> fetchToursmDetail(int id) async {
    try {
      _resultState = TourismDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getTourismDetail(id);

      if (result.error) {
        _resultState = TourismDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = TourismDetailLoadedState(result.places);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = TourismDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}