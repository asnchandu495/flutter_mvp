
import 'package:flutter_mvp/Login/Presenter/PresenterView.dart';
import 'package:flutter_mvp/Login/model/model.dart';

import '../services/remote/response/ApiResponse.dart';
import '../services/user_data_service.dart';


import 'package:flutter/material.dart';
import 'package:flutter_mvp/Login/model/model.dart';
import 'package:flutter_mvp/Login/services/remote/response/ApiResponse.dart';
import 'package:flutter_mvp/Login/services/user_data_service.dart';

class HomePresenter  {
  final _myRepo = UserDataService();
  ApiResponse<User> userModel = ApiResponse.loading();

  PresenterView? _view;

  HomePresenter(this._view);

  // HomePresenter(this._view) {
  //   _paymentsApiService = new PaymentApiService();
  // }

  void _setUserMain(User response) {
    print("Response: $response");
    // userModel = response;
    // notifyListeners();
    _view?.showListDetail(response);
  }

  Future<void> fetchUserData() async {
    // _setUserMain(ApiResponse.loading());
    print("fetchdata");
    _myRepo
        .getUserData()
        .then((value) => _setUserMain(value))
        .onError((error, stackTrace) => _view?.showError());

    //_view.showListDetail(value);

    // _myRepo
    //     .getUserData()
    //     .then((value) => _setUserMain(ApiResponse.completed(value)))
    //     .onError((error, stackTrace) => _setUserMain(ApiResponse.error(error.toString())));
  }

}