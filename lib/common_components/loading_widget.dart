import 'package:flutter/material.dart';
import 'package:tasks_status_architecture/common_components/custom_popup_route.dart';
import 'package:tasks_status_architecture/common_components/nav_service.dart';

class LoadingDialog {
  LoadingDialog._();

  static LoadingDialog _instance = LoadingDialog._();

  factory LoadingDialog() => _instance;
  bool _showing = false;

  show() {
    if (!_showing) {
      _showing = true;
      NavService.navKey.currentState
          .push(CustomPopupRoutes(
              pageBuilder: (_, __, ___) {
                print("building loader");
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              barrierDismissible: false))
          .then((_) {});
    }
  }

  hide() {
    print("hide called");
    if (_showing) {
      NavService.navKey.currentState.pop();
      _showing = false;
    }
  }
}
