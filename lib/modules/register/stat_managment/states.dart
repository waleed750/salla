import 'package:salla/models/shop_login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessfulState extends ShopRegisterStates
{
  final ShopLoginModel loginModel;

  ShopRegisterSuccessfulState(this.loginModel);

}

class ShopRegisterErrorState extends ShopRegisterStates
{
  final String error;
  ShopRegisterErrorState({required this.error});
}

class ShopRegisterChangeVisibilityState extends ShopRegisterStates{}
