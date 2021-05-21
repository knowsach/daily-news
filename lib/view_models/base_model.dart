import 'package:flutter/material.dart';

class BaseModel with ChangeNotifier {
  Map<String, Status> status = {'main': Status.Idle};
  Map<String, String> error = {};
  Map<String, dynamic> data = <String, dynamic>{};

  setStatus(String taskName, Status _status) {
    this.status[taskName] = _status;
    notifyListeners();
  }

  setData(String taskName, dynamic _data) {
    this.data[taskName] = _data;
  }

  setError(String taskName, String _error, [Status _status]) {
    if (_error != null) {
      error[taskName] = _error;
      status[taskName] = Status.Error;
    } else {
      this.error[taskName] = null;
      this.status[taskName] = _status ?? Status.Idle;
    }
    notifyListeners();
  }

  reset(String taskName) {
    this.error?.remove(taskName);
    this.status?.remove(taskName);
  }
}

enum Status { Loading, Done, Error, Idle }
