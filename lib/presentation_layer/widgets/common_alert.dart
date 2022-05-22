import 'package:flutter/material.dart';
import 'package:posts/constants/colors.dart';
import 'package:posts/data_layer/providers/language_provider.dart';
import 'package:provider/provider.dart';

class CommonAlert extends StatelessWidget {
  final Function actionMethod;
  final String content, cancelBtn, actionBtn;

  const CommonAlert(
      {Key? key,
      required this.actionMethod,
      required this.content,
      required this.cancelBtn,
      required this.actionBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, provider, child) {
        return AlertDialog(
          elevation: 2,
          backgroundColor: AppColors.white,
          contentTextStyle: const TextStyle(
              fontSize: 12, color: AppColors.secondary, fontFamily: "Almarai"),
          content: Text(content),
          actions: <Widget>[
            Builder(
              builder: (context) {
                return TextButton(
                  child: Text(
                    actionBtn,
                    style:
                        const TextStyle(fontSize: 12, color: AppColors.primary),
                  ),
                  onPressed: () async => actionMethod(),
                );
              },
            ),
            TextButton(
              child: Text(cancelBtn,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.secondary)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
