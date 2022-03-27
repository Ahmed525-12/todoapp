import 'package:flutter/material.dart';

void showLoading(String showmesg, BuildContext context,
    {bool isCanceld = false}) {
  showDialog(
      barrierDismissible: isCanceld,
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(showmesg),
                )
              ],
            ),
          ),
        );
      });
}

void hideDialog(BuildContext context) {
  Navigator.pop(context);
}

void showMesage(String showmesg, BuildContext context, String posActionbutton,
    VoidCallback posAction,
    {String? negActionText = null, VoidCallback? negAction = null,bool isCanceld=true}) {
  List<Widget> acytions = [
    TextButton(onPressed: posAction, child: Text(posActionbutton))
  ];
  if (negActionText != null) {
    acytions.add(TextButton(onPressed: negAction, child: Text(negActionText)));
  }
  showDialog(
    barrierDismissible: isCanceld,
      context: context,
      builder: (buildcontext) {
        
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(showmesg),
          ),
          actions: acytions,
        );
      });
}
