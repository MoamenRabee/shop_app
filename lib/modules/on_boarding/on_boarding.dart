import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {

    PageController pageViewController = PageController();
    int index_page = 0;


    void canclePage(){
      CacheHelper.putBoolenData("onBoarding", true).then((value){
        NavigateOff(context,LoginScreen());
      });
    }


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      canclePage();
                    },
                    child: Text(
                      "SKIP",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: pageViewController,
                  children: [
                    PageViewItem(
                      title: "Choose from products",
                      description: "Ease of adding products to your shopping cart, choose from the displayed products.",
                      image: "assets/images/on_boarding_1.png",
                    ),
                    PageViewItem(
                      title: "Confirm your purchase",
                      description: "Confirm the purchase after selecting it, and reviewing it from the shopping cart.",
                      image: "assets/images/on_boarding_2.png",
                    ),
                    PageViewItem(
                      title: "Shipping home",
                      description: "There is delivery to your door at the lowest possible cost.",
                      image: "assets/images/on_boarding_3.png",
                    ),
                  ],
                  onPageChanged: (page) {
                    index_page = page;
                  },

                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: pageViewController,
                    count:  3,
                    axisDirection: Axis.horizontal,
                    effect:  ExpandingDotsEffect(
                        spacing:  10.0,
                        radius:  50.0,
                        dotWidth:  12.0,
                        dotHeight:  12.0,
                        paintStyle:  PaintingStyle.fill,
                        strokeWidth:  1.5,
                        dotColor:  Colors.grey,
                        activeDotColor:  Colors.blue
                    )
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (index_page == 2) {
                        canclePage();
                      } else {
                        pageViewController.nextPage(
                            duration: Duration(milliseconds: 800),
                            curve: Curves.fastOutSlowIn,
                        );
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




Widget PageViewItem({
  @required String? image,
  @required String? title,
  @required String? description,
}) {
  return Column(
    children: [
      Expanded(
        child: Image(
          image: AssetImage(
            "${image}",
          ),
        ),
      ),
      Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${title}",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                end: 20.0
              ),
              child: Text(
                "${description}",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
          ],
        ),
      ),
    ],
  );
}
