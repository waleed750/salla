import 'package:salla/models/shop_login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessfulState extends ShopLoginStates
{
  final ShopLoginModel loginModel;

  ShopLoginSuccessfulState(this.loginModel);

}

class ShopLoginErrorState extends ShopLoginStates
{
  final String error;
  ShopLoginErrorState({required this.error});
}

class ShopChangeVisibilityState extends ShopLoginStates{}
