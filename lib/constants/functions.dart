import 'package:posts/data_layer/providers/home_provider.dart';
import 'package:posts/data_layer/providers/profile_provider.dart';
import 'package:posts/data_layer/providers/tabs_provider.dart';
import 'package:posts/data_layer/providers/language_provider.dart';
import 'package:posts/data_layer/providers/login_provider.dart';
import 'package:posts/data_layer/providers/sign_up_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Functions {
  Functions._();

  static List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider.value(value: LanguageProvider()),
      ChangeNotifierProvider.value(value: LoginProvider()),
      ChangeNotifierProvider.value(value: SignUpProvider()),
      ChangeNotifierProvider.value(value: TabsProvider()),
      ChangeNotifierProvider.value(value: HomeProvider()),
      ChangeNotifierProvider.value(value: ProfileProvider()),
    ];
  }
}
