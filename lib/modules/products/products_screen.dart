import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeLayoutCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.homeData != null && cubit.categories != null,
            builder: (context) => Column(
              children: [
                Container(
                    child: defultCarouselSlider(cubit.homeData!.data.banners,),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 50.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) => CategoryWidget(cubit.categories!.data!.data![index].image.toString(),cubit.categories!.data!.data![index].name.toString()),
                      separatorBuilder: (context,index) => SizedBox(width: 10.0,),
                      itemCount: cubit.categories!.data!.data!.length,
                  )
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "products",
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        width: double.infinity,
                      ),
                      // Start Add Products Design


                      // End Add Products Design
                    ],
                  ),
                ),
              ],
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.blue,),),
          );
      },
    );
  }
}


Widget defultCarouselSlider(List mylist){
  return CarouselSlider.builder(
    options: CarouselOptions(
      height: 200.0,
      autoPlay: true,
      scrollPhysics: BouncingScrollPhysics(),
      viewportFraction: 1.0,
      //autoPlayAnimationDuration: Duration(milliseconds: 800),
    ),
    itemCount: mylist.length,
    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
      return Image(
        image: NetworkImage(mylist[itemIndex].image),
        fit: BoxFit.cover,
      );
    },
  );
}

Widget CategoryWidget(String image,String lable){
  return Container(
    child: Row(
      children: [
        CircleAvatar(
          radius: 20.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image(
              image: NetworkImage("${image}"),
              height: 40.0,
              width: 40.0,
              fit: BoxFit.cover,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        SizedBox(width: 10.0,),
        Text(
          "${lable}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ],
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
    height: 50.0,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}