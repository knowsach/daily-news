/// This is a custom widget to handle states from view models
/// This takes in a [functionName] as a String to render only function which is called,
/// a [successBuilder] which tells what to render is status is [Status.Done]
/// [Status.Loading] renders a CircularProgressIndicator whereas
/// [Status.Error] renders [errorBuilder]

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_status_architecture/view_models/base_model.dart';

class ProviderHandler<T extends BaseModel> extends StatelessWidget {
  final Widget Function(T) successBuilder;
  final Widget Function(T) errorBuilder;
  final Widget Function(T) loaderBuilder;
  final String functionName;
  final bool showError;
  final Function(T) load;

  const ProviderHandler(
      {Key key,
      this.successBuilder,
      this.errorBuilder,
      this.functionName,
      this.showError,
      this.loaderBuilder,
      this.load})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<T>(builder: (context, _provider, __) {
      if (_provider?.status[functionName] == Status.Loading) {
        return loaderBuilder(_provider) ??
            Center(
              child: Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
      } else if (_provider?.status[functionName] == Status.Error) {
        if (showError) {
          // ErrorDialog()
          //     .show(_provider.error[functionName].toString(), context: context);
          AlertDialog();
          _provider.reset(functionName);
          return SizedBox();
        } else {
          _provider.reset(functionName);
          return errorBuilder(_provider);
        }
      } else if (_provider?.status[functionName] == Status.Done) {
        return successBuilder(_provider);
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await load(_provider);
        });
        return Center(
          child: Container(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
