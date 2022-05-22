import 'package:flutter/material.dart';
import 'package:posts/constants/colors.dart';
import 'package:posts/constants/variables.dart';
import 'package:posts/data_layer/providers/sign_up_provider.dart';
import 'package:posts/data_layer/repository/auth_repo.dart';
import 'package:posts/localization/language_constants.dart';
import 'package:posts/presentation_layer/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _email = TextEditingController(text: "");
  late final TextEditingController _password = TextEditingController(text: "");
  late final TextEditingController _confirmPassword =
      TextEditingController(text: "");
  late final TextEditingController _fName = TextEditingController(text: "");
  late final TextEditingController _lName = TextEditingController(text: "");

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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon:
                          const Icon(Icons.arrow_back, color: AppColors.arrow),
                    ),
                    Text(
                      getTranslated(context, "register"),
                      style: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                        label: getTranslated(context, "email"),
                        controller: _email),
                    const SizedBox(height: 18.44),
                    Selector<SignUpProvider, bool>(
                      selector: (context, provider) => provider.showPass,
                      builder: (context, showPass, child) {
                        return CustomFormField(
                          label: getTranslated(context, "password"),
                          controller: _password,
                          obscure: !showPass,
                          suffixIcon: InkWell(
                            onTap: () {
                              Provider.of<SignUpProvider>(context,
                                      listen: false)
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
                    const SizedBox(height: 18.44),
                    Selector<SignUpProvider, bool>(
                      selector: (context, provider) => provider.showConfirmPass,
                      builder: (context, showConfirmPass, child) {
                        return CustomFormField(
                          label: getTranslated(context, "confirm_password"),
                          controller: _confirmPassword,
                          obscure: !showConfirmPass,
                          suffixIcon: InkWell(
                            onTap: () {
                              Provider.of<SignUpProvider>(context,
                                      listen: false)
                                  .updateShowConfirmPass(!showConfirmPass);
                            },
                            child: Icon(
                              showConfirmPass
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.lightGrey_60,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18.44),
                    CustomFormField(
                        label: getTranslated(context, "f_name"),
                        controller: _fName),
                    const SizedBox(height: 18.44),
                    CustomFormField(
                        label: getTranslated(context, "l_name"),
                        controller: _lName),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () => _register(context),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    getTranslated(context, "register"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.background,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _register(BuildContext context) {
    AuthRepo()
        .register(_email.text.trim(), _password.text.trim())
        .then((value) async {
      if (value != null) {
        Navigator.of(context).pushNamed(Variables.tabsScreen);
        SharedPreferences sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString(Variables.userEmail, _email.text.trim());
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
