import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:posts/constants/colors.dart';
import 'package:posts/constants/variables.dart';
import 'package:posts/data_layer/providers/login_provider.dart';
import 'package:posts/data_layer/repository/auth_repo.dart';
import 'package:posts/localization/language_constants.dart';
import 'package:posts/presentation_layer/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _userName = TextEditingController(text: "");
  late final TextEditingController _password = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Text(
                getTranslated(context, "login"),
                style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                        label: getTranslated(context, "user_name"),
                        controller: _userName),
                    const SizedBox(height: 18.44),
                    Selector<LoginProvider, bool>(
                      selector: (context, provider) => provider.showPass,
                      builder: (context, showPass, child) {
                        return CustomFormField(
                          label: getTranslated(context, "password"),
                          controller: _password,
                          obscure: !showPass,
                          suffixIcon: InkWell(
                            onTap: () {
                              Provider.of<LoginProvider>(context, listen: false)
                                  .updateShowPass(!showPass);
                            },
                            child: Icon(
                              showPass
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.lightGrey_60,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  getTranslated(context, "forget_password"),
                  style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () => _login(context),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    getTranslated(context, "login"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.background,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                        child: Divider(color: AppColors.grey, thickness: 1)),
                    Text(
                      getTranslated(context, "or"),
                      style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    const Expanded(
                        child: Divider(color: AppColors.grey, thickness: 1)),
                  ],
                ),
              ),
              Text(
                getTranslated(context, "if_have_not_account"),
                style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(Variables.signUpScreen),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    // color: AppColors.primary,
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person_add_alt,
                          color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text(
                        getTranslated(context, "register_new_account"),
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login(BuildContext context) {
    AuthRepo()
        .login(_userName.text.trim(), _password.text.trim())
        .then((value) async {
      if (value != null) {
        Navigator.of(context).pushNamed(Variables.tabsScreen);
        SharedPreferences sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString(Variables.userEmail, _userName.text.trim());
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Ops! Login Failed"),
            content: Text('${value.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okay'),
              )
            ],
          ),
        );
      }
    });
  }
}
