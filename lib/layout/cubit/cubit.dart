import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories/products_screen.dart';
import 'package:shop_app/modules/favorites/products_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/products_screen.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates>{

  HomeLayoutCubit() : super(HomeLayoutInitialStates());

  static HomeLayoutCubit get(context)=>BlocProvider.of(context);

  int currentNavBarIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeCurrentNavBarIndex(int index){
    currentNavBarIndex = index;
    emit(HomeLayoutChangeNavBarIndexStates());
  }


  HomeModel? homeData;

  getHomeData(){
    emit(HomeLayoutGetHomeDataLoadingStates());
    DioHelper.getData(
      url: HOME,
      token: CacheHelper.getData("UserToken"),
    ).then((value){
      // LOAD DATA IN HOME MODEL
      homeData = HomeModel.fromJson(value!.data);

      emit(HomeLayoutGetHomeDataSuccessStates());
    }).catchError((error){
      print(error);
      emit(HomeLayoutGetHomeDataErrorStates());
    });
  }



  CategoriesModel? categories;

  getCategoriesHome(){
    emit(HomeLayoutGetCategoriesLoadingStates());

    DioHelper.getData(
      url: CATEGORIES,
    ).then((value){
      // LOAD DATA IN HOME MODEL
      categories = CategoriesModel.fromJson(value!.data);

      emit(HomeLayoutGetCategoriesSuccessStates());
    }).catchError((error){
      print(error);
      emit(HomeLayoutGetCategoriesErrorStates());
    });
  }


}