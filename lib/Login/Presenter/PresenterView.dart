

import 'package:flutter_mvp/Login/model/model.dart';

abstract class PresenterView {
  void showListDetail(User items);

  void showError();
}