import 'package:flutter/material.dart';
import 'package:tasks_status_architecture/common_components/custom_popup_route.dart';
import 'package:tasks_status_architecture/common_components/nav_service.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String text, buttonText;
  final Function onButtonPress;
  final bool includeCancel;

  ErrorDialogWidget({
    @required this.text,
    this.buttonText,
    this.onButtonPress,
    this.includeCancel,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          height: 240,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Some Error occured',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text(
                        'OK',
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onButtonPress != null) onButtonPress();
                      },
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorDialog {
  ErrorDialog._();

  static ErrorDialog _instance = ErrorDialog._();

  factory ErrorDialog() => _instance;
  bool _showing = false;
  var appLocal;

  show(String text,
      {String buttonText,
      Function onButtonPressed,
      @required BuildContext context,
      bool includeCancel = false}) {
    if (!_showing) {
      _showing = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        NavService.navKey.currentState
            .push(
          CustomPopupRoutes(
              pageBuilder: (_, __, ___) => ErrorDialogWidget(
                    text: text.toString(),
                    buttonText: (buttonText == null) ? 'ok' : buttonText,
                    onButtonPress: onButtonPressed,
                    includeCancel: includeCancel,
                  ),
              barrierDismissible: true),
        )
            .then((_) {
          print("hidden error");
          _showing = false;
        });
      });
    }
  }

  hide() {
    if (_showing) NavService.navKey.currentState.pop();
  }
}
