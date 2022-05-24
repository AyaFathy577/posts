import 'dart:io';
import 'package:flutter/material.dart';
import 'package:posts/constants/colors.dart';
import 'package:posts/data_layer/models/post_model.dart';
import 'package:posts/data_layer/providers/home_provider.dart';
import 'package:posts/localization/language_constants.dart';
import 'package:posts/presentation_layer/widgets/add_post_dialog.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addPost(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Selector<HomeProvider, List<PostModel>>(
          shouldRebuild: (previous, next) => true,
          selector: (context, provider) => provider.posts,
          builder: (context, posts, child) {
            return posts.isNotEmpty
                ? ListView.builder(
                    itemCount: posts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsetsDirectional.only(
                            bottom: 16, start: 16, end: 16),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.lightBlue,
                                blurRadius: 12,
                                offset: Offset(0, 3)),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightBlue_20,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: const Icon(Icons.person,
                                        color: AppColors.lightBlue),
                                  ),
                                  SizedBox(
                                    height: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Share.share('Hello from Posts App');
                                          },
                                          icon: const Icon(
                                            Icons.share,
                                            color: AppColors.darkBlue,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.bookmark,
                                            color: AppColors.lightBlue,
                                          ),
                                        ),
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4),
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.thumb_up,
                                                  color: AppColors.lightBlue,
                                                ),
                                              ),
                                            ),
                                            const PositionedDirectional(
                                              end: 20,
                                              bottom: 0,
                                              child: Text(
                                                "5",
                                                style: TextStyle(
                                                    color: AppColors.lightBlue),
                                              ),
                                            )
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () => _removePost(index),
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: AppColors.darkBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.file(
                                  File(posts[index].link),
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  bottom: 8, start: 8, end: 8),
                              child: Text(
                                posts[index].description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 14,
                                  height: 1.8,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(getTranslated(context, "empty")),
                  );
          },
        ),
      ),
    );
  }

  _addPost(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false).init();
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          contentPadding: EdgeInsets.all(16),
          content: AddPostDialog(),
        );
      },
    );
  }

  void _getData() {
    HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);
    provider.getPosts();
  }

  _removePost(int index) {
    HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);
    provider.removePost(index);
  }
}
