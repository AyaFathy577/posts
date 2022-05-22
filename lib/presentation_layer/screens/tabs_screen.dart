import 'package:flutter/material.dart';
import 'package:posts/constants/colors.dart';
import 'package:posts/data_layer/providers/tabs_provider.dart';
import 'package:posts/localization/language_constants.dart';
import 'package:posts/presentation_layer/screens/home_screen.dart';
import 'package:posts/presentation_layer/screens/profile_screen.dart';
import 'package:posts/presentation_layer/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen>
    with SingleTickerProviderStateMixin {
  final List<Widget> _children = [
    const HomeScreen(),
    const ProfileScreen(),
  ];
  TabController? controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: AppDrawer(tabController: controller),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Selector<TabsProvider, int>(
            selector: (context, provider) => provider.index,
            builder: (context, index, child) {
              return AppBar(
                backgroundColor: AppColors.darkBlue,
                title: index == 0
                    ? Text(getTranslated(context, "home"))
                    : Text(getTranslated(context, "profile")),
                bottom: TabBar(
                  onTap: (val) {
                    Provider.of<TabsProvider>(context, listen: false)
                        .updateIndex(val);
                  },
                  controller: controller,
                  indicatorColor: AppColors.white,
                  labelStyle:
                      const TextStyle(fontFamily: "Almarai", fontSize: 18),
                  tabs: [
                    Tab(text: getTranslated(context, "home")),
                    Tab(text: getTranslated(context, "profile")),
                  ],
                ),
              );
            },
          ),
        ),
        body: Selector<TabsProvider, int>(
          selector: (context, provider) => provider.index,
          builder: (context, index, child) {
            return _children[index];
          },
        ),
      ),
    );
  }
}
