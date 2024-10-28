import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:continuelearning/NewsApp/modules/webview_screen.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(
        {required Map<String, dynamic> article, required context}) =>
    InkWell(
      onTap: () {
        navigateTo(
            context: context, widget: WebViewScreen(article['url'].toString()));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage("${article['urlToImage']}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${article['title']}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text("${article['publishedAt']}"),
                ],
              ),
            )
          ],
        ),
      ),
    );

Widget articleBuilder(
        {required List list,
        required RefreshCallback function,
        bool isSearch = false}) =>
    ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => RefreshIndicator(
        color: Colors.deepOrange,
        onRefresh: function,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return buildArticleItem(article: list[index], context: context);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            );
          },
          itemCount: list.length,
        ),
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
            ),
    );

void navigateTo({required BuildContext context, required Widget widget}) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}
