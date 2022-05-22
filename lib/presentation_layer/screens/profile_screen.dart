import 'package:flutter/material.dart';
import 'package:posts/constants/colors.dart';
import 'package:posts/data_layer/providers/profile_provider.dart';
import 'package:posts/localization/language_constants.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: size.width,
          height: size.height * 0.37,
          child: Stack(
            children: [
              PositionedDirectional(
                top: 0,
                start: 0,
                end: 0,
                child: Image.network(
                  "https://images.pexels.com/photos/302743/pexels-photo-302743.jpeg",
                  height: size.height * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              PositionedDirectional(
                bottom: 0,
                start: (size.width * 0.5) - (size.height * 0.15) / 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size.height * 0.15),
                  child: Image.network(
                    "https://images.pexels.com/photos/302743/pexels-photo-302743.jpeg",
                    height: size.height * 0.15,
                    width: size.height * 0.15,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Text(
          getTranslated(context, "account_name"),
          style: const TextStyle(
            color: AppColors.secondary,
            fontSize: 18,
            height: 1.8,
            fontWeight: FontWeight.w600,
          ),
        ),
        Selector<ProfileProvider, String>(
          selector: (context, provider) => provider.userEmail,
          builder: (context, userEmail, child) {
            return Text(
              userEmail,
              style: const TextStyle(
                color: AppColors.lightBlue,
                fontSize: 12,
                height: 1.8,
                fontWeight: FontWeight.w400,
              ),
            );
          },
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: AppColors.white),
                ),
                Text(
                  getTranslated(context, "edit_info"),
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 14,
                    height: 1.8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.settings, color: AppColors.white),
                ),
                Text(
                  getTranslated(context, "settings"),
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 14,
                    height: 1.8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.star, color: AppColors.white),
                ),
                Text(
                  getTranslated(context, "favourite"),
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 14,
                    height: 1.8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _getData() {
    Provider.of<ProfileProvider>(context, listen: false).getUserEmail();
  }
}
