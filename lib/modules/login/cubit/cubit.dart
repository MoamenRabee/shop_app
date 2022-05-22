import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit() : super(LoginInitialStates());


  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  Icon suffixIcon = Icon(Icons.visibility,color: Colors.grey,);

  void changeIsPassword(){
    isPassword = !isPassword;
    suffixIcon = Icon(Icons.visibility_off,color: Colors.grey,);
    emit(LoginChangeIsPasswordStates());
  }


  LoginModel? userData;

  bool? buttonIsLoading = false;

  void loginUser(String email,String password,context){
    emit(LoginLoadingStates());
    buttonIsLoading = true;

    DioHelper.postData(
      url: LOGIN,
      data: {
        "email" : email,
        "password" : password,
      }
    ).then((value) async {
      // load data in model
      userData = LoginModel.fromJson(value!.data);
      buttonIsLoading = false;

      if(userData!.status == true){
        await ShowToast(
          msg: "Log in Succsess",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        CacheHelper.putStringData("UserToken", userData!.data!.token.toString()).then((value){
          NavigateOff(context, HomeLayout());
        });
      }else{
        await ShowToast(
          msg: "Log in Field",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }

      emit(LoginSuccessStates());
    }).catchError((error) async {
      print(error.toString());
      buttonIsLoading = false;
      await ShowToast(
        msg: "Log in Field : Error from Server",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      emit(LoginErrorStates());
    });
  }



}