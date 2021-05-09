import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_status_architecture/view_models/base_model.dart';

Future providerCallback<T extends BaseModel>(BuildContext context,
    {@required final Function(T) task,
    @required final String Function(T) taskName,
    @required Function(T) onSuccess,
    bool showDialog = true,
    bool showLoader = true,
    Function onErrorHandeling,
    Function onError}) async {
  final T _provider = Provider.of<T>(context, listen: false);
  String _taskName = taskName(_provider);

  if (showLoader) ;
  await Future.microtask(() => task(_provider));
  if (showLoader)
    return Center(
      child: CircularProgressIndicator(),
    );
  print(
      'status before=====>_provider.status[_taskName]====>${_provider.status[_taskName]}');
  if (_provider.status[_taskName] == Status.Error) {
    if (showDialog) {
      // ErrorDialog().show(
      //   _provider.error[_taskName].toString(),
      //   context: context,
      //   onButtonPressed: onErrorHandeling,
      // );
    }

    if (onError != null) onError(_provider);

    _provider.reset(_taskName);
    print(
        'status before=====>_provider.status[_taskName]====>${_provider.status[_taskName]}');
  } else if (_provider.status[_taskName] == Status.Done) {
    onSuccess(_provider);
  }
}
