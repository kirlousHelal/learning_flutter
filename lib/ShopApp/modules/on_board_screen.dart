import 'package:continuelearning/ShopApp/models/page_model.dart';
import 'package:continuelearning/ShopApp/modules/login/login_screen.dart';
import 'package:continuelearning/ShopApp/shared/components/components.dart';
import 'package:continuelearning/ShopApp/shared/network/local/cache_helper.dart';
import 'package:continuelearning/ShopApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardScreen extends StatelessWidget {
  PageController pageController = PageController();

  bool isLast = false;

  List<PageModel> pages = [
    PageModel(
        image: "assets/images/page 1.jpg",
        title: "Screen Title 1 ",
        body: "Screen body 1"),
    PageModel(
        image: "assets/images/page 2.jpg",
        title: "Screen Title 2 ",
        body: "Screen body 2"),
    PageModel(
        image: "assets/images/page 3.jpg",
        title: "Screen Title 3 ",
        body: "Screen body 3"),
  ];

  OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              onPress: () {
                CacheHelper.saveData(key: "onboarding", value: true).then(
                  (value) => print(value),
                );
                navigateTo(
                    context: context,
                    widget: LoginScreen(),
                    removeAllPrevious: true);
              },
              text: "Skip",
              foregroundColor: defaultColor),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => pageView(pages[index]),
                physics: const BouncingScrollPhysics(),
                itemCount: pages.length,
                controller: pageController,
                onPageChanged: (index) {
                  if (index == pages.length - 1)
                    isLast = true;
                  else
                    isLast = false;
                },
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    effect: ScrollingDotsEffect(
                      spacing: 150 / pages.length,
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      fixedCenter: true,
                    ),
                    count: pages.length,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      CacheHelper.saveData(key: "onboarding", value: true)
                          .then((value) {
                        print(value);
                      });
                      navigateTo(
                          context: context,
                          widget: LoginScreen(),
                          removeAllPrevious: true);
                      return;
                    }
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget pageView(PageModel model) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(model.image),
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ],
      );
}
