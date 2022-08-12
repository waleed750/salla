import 'package:flutter/material.dart';
import 'package:salla/models/shop_login_model.dart';
import 'package:salla/layout/shop_layout.dart';
import 'package:salla/modules/login/stat_managment/states.dart';
import 'package:salla/shared/common/constants.dart';
import 'package:salla/shared/imports/exports.dart';
import 'package:salla/shared/network/local/cash_helper.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';
import 'package:salla/shared/network/remote/end_points.dart';

import 'states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super (ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  var icon = Icons.visibility_off ;

  ShopLoginModel? loginModel ;

  void userRegister({
  required String email ,
    required String name ,
    required String phone ,
    required String password
}) async
  {
      emit(ShopRegisterLoadingState());
      var value = await DioHelper.postData(path: REGISTER ,

        data: {
        'email':email ,
          'name' : name,
          'phone' :phone ,
          'password' : password
        }
      ).catchError((error) {
        emit(ShopRegisterErrorState(error: error.toString() ));
      });

      loginModel = ShopLoginModel.fromJson(value.data);
      if(loginModel!.data != null)
        {
          token = loginModel!.data!.token;
          await CashHelper.setData(key: 'token',
              value: token);
        }
      emit(ShopRegisterSuccessfulState(loginModel!));
  }
  void changeVisibility ()
  {
    isPassword= !isPassword;
    icon = icon == Icons.visibility_off ? Icons.visibility :Icons.visibility_off ;
    emit(ShopRegisterChangeVisibilityState());
  }
}