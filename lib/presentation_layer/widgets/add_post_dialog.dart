import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posts/constants/colors.dart';
import 'package:posts/data_layer/providers/home_provider.dart';
import 'package:posts/localization/language_constants.dart';
import 'package:provider/provider.dart';

class AddPostDialog extends StatefulWidget {
  const AddPostDialog({Key? key}) : super(key: key);

  @override
  State<AddPostDialog> createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => _showDialog(context),
              child: Container(
                width: size.width,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                    color: AppColors.lightBlue_20,
                    borderRadius: BorderRadius.circular(6)),
                child: Selector<HomeProvider, XFile?>(
                  selector: (context, provider) => provider.pickedFile,
                  builder: (context, pickedFile, child) {
                    return pickedFile != null
                        ? Image.file(File(pickedFile.path))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.camera_alt,
                                  color: AppColors.lightBlue, size: 64),
                              Text(
                                getTranslated(context, "upload_image"),
                                style: const TextStyle(
                                  color: AppColors.lightBlue,
                                  fontSize: 14,
                                  height: 1.8,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              getTranslated(context, "write_description"),
              style: const TextStyle(
                color: AppColors.lightBlue,
                fontSize: 12,
                height: 1.8,
                fontWeight: FontWeight.w400,
              ),
            ),
            Selector<HomeProvider, String>(
              selector: (context, provider) => provider.description,
              builder: (context, description, child) {
                return TextField(
                  maxLines: 4,
                  maxLength: 120,
                  cursorColor: AppColors.primary,
                  style:
                      const TextStyle(color: AppColors.secondary, fontSize: 14),
                  onChanged: (val) {
                    Provider.of<HomeProvider>(context, listen: false)
                        .updateText(val);
                  },
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primary, width: 2),
                    ),
                    counter: Text(
                      "${description.length}/120",
                      style: const TextStyle(
                        color: AppColors.lightBlue,
                        fontSize: 12,
                        height: 1.8,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    getTranslated(context, "ignore"),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      height: 1.8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Text(
                    getTranslated(context, "publish"),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      height: 1.8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onImageButtonPressed(
      BuildContext context, ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    try {
      XFile? pickedFile = await _picker.pickImage(source: source);
      Navigator.of(context).pop();
      Provider.of<HomeProvider>(context, listen: false)
          .updatePicked(pickedFile);
    } catch (e) {
      log("error when pick image");
    }
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _onImageButtonPressed(context, ImageSource.camera);
                  },
                  child: Text(
                    getTranslated(context, "camera"),
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                      height: 1.8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(color: AppColors.lightBlue),
                InkWell(
                  onTap: () {
                    _onImageButtonPressed(context, ImageSource.gallery);
                  },
                  child: Text(
                    getTranslated(context, "gallery"),
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                      height: 1.8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
