import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => HomeLayoutCubit()..getHomeData()..getCategoriesHome(),
        child: BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
          listener: (context,state){},
          builder: (context,state){
            var cubit = HomeLayoutCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text("Shop App"),
                actions: [
                  IconButton(
                      onPressed: (){
                        CacheHelper.DeleteData("UserToken");
                        NavigateOff(context, LoginScreen());
                      },
                      icon: Icon(Icons.logout),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.search),
                  )
                ],
              ),
              body: cubit.screens[cubit.currentNavBarIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentNavBarIndex,
                onTap: (index){
                  cubit.changeCurrentNavBarIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: "Products"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.class__outlined),
                      label: "Category"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border),
                      label: "Favorite"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: "Settings"
                  ),
                ],
              ),
            );
          },
        ),
    );
  }
}
