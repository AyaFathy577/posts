import 'package:flutter/material.dart';
import 'package:posts/constants/colors.dart';
import 'package:posts/constants/variables.dart';
import 'package:posts/data_layer/models/language_model.dart';
import 'package:posts/data_layer/providers/tabs_provider.dart';
import 'package:posts/localization/language_constants.dart';
import 'package:posts/main.dart';
import 'package:posts/presentation_layer/widgets/common_alert.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final TabController? tabController;

  const AppDrawer({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            color: AppColors.drawer,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 49,
                  width: 49,
                  decoration: const BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.all(Radius.circular(49)),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.background,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "name",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          InkWell(
            onTap: () {
              Provider.of<TabsProvider>(context, listen: false).updateIndex(0);
              if (tabController != null) tabController!.index = 0;
              Navigator.of(context).pop();
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  const SizedBox(width: 36),
                  const Icon(Icons.home, color: AppColors.drawer),
                  const SizedBox(width: 14.5),
                  Text(
                    getTranslated(context, 'home'),
                    style: const TextStyle(
                        color: AppColors.drawer,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Divider(color: AppColors.lightBlue_20, thickness: 1),
          ),
          InkWell(
            onTap: () {
              Provider.of<TabsProvider>(context, listen: false).updateIndex(1);
              if (tabController != null) tabController!.index = 1;
              Navigator.of(context).pop();
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  const SizedBox(width: 36),
                  const Icon(Icons.person, color: AppColors.drawer),
                  const SizedBox(width: 14.5),
                  Text(
                    getTranslated(context, 'profile'),
                    style: const TextStyle(
                        color: AppColors.drawer,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Divider(color: AppColors.lightBlue_20, thickness: 1),
          ),
          InkWell(
            onTap: () {
              // Provider.of<TabsProvider>(context, listen: false)
              //     .updateIndex(1);
              // Navigator.of(context).pop();
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  const SizedBox(width: 36),
                  const Icon(Icons.bookmark, color: AppColors.drawer),
                  const SizedBox(width: 14.5),
                  Text(
                    getTranslated(context, 'favourite'),
                    style: const TextStyle(
                        color: AppColors.drawer,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Divider(color: AppColors.lightBlue_20, thickness: 1),
          ),
          SizedBox(
            height: 30,
            child: Row(
              children: [
                const SizedBox(width: 36),
                const Icon(Icons.language, color: AppColors.drawer),
                const SizedBox(width: 14.5),
                DropdownButton<Language>(
                  iconSize: 0,
                  underline: Container(),
                  hint: Text(
                    getTranslated(context, "change_language"),
                    style: const TextStyle(
                        color: AppColors.drawer,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  onChanged: (Language? language) =>
                      _changeLanguage(context, language!),
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Text(
                            e.name,
                            style: const TextStyle(
                                color: AppColors.drawer,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Divider(color: AppColors.lightBlue_20, thickness: 1),
          ),
          InkWell(
            onTap: () => _showDialog(context),
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  const SizedBox(width: 36),
                  const Icon(Icons.logout, color: AppColors.drawer),
                  const SizedBox(width: 14.5),
                  Text(
                    getTranslated(context, 'log_out'),
                    style: const TextStyle(
                        color: AppColors.drawer,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeLanguage(BuildContext context, Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
    Navigator.of(context).pushNamed(Variables.splashScreen);
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonAlert(
          actionMethod: () => _logOut(context),
          content: getTranslated(context, 'confirm_log_out'),
          actionBtn: getTranslated(context, 'ok'),
          cancelBtn: getTranslated(context, 'cancel'),
        );
      },
    );
  }

  void _logOut(BuildContext context) {
    // SharedPref sharedPref = SharedPref();
    // sharedPref.removeAll();
    Navigator.pushNamedAndRemoveUntil(
        context, Variables.loginScreen, (route) => false);
  }
}
