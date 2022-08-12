import 'package:salla/models/shop_login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopHomeSuccessfulState extends ShopStates{}

class ShopHomeLoadingState extends ShopStates{}

class ShopHomeErrorState extends ShopStates
{
  final error;

  ShopHomeErrorState(this.error);
}

class ShopChangeNavBottomState extends ShopStates{}

class ShopGetCategoriesLoadingState extends ShopStates{}

class ShopGetCategoriesSuccessfulState extends ShopStates{}

class ShopGetCategoriesErrorState extends ShopStates{
  final String error;

  ShopGetCategoriesErrorState(this.error);
}
class ShopGetFavoritesSuccessfulState extends ShopStates {}

class ShopGetFavoritesLoadingState extends ShopStates {}

class ShopGetFavoritesErrorState extends ShopStates{
  final String error;

  ShopGetFavoritesErrorState(this.error);
}

class ShopChangeFavSuccessfulState extends ShopStates {}

class ShopChangeFavErrorState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);

}

class ShopLoadingUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {
  final String error ;

  ShopErrorUserDataState(this.error);
}

class ShopUpdateUserSuccessfulState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopUpdateUserSuccessfulState(this.loginModel);

}

class ShopUpdateUserLoadingState extends ShopStates {}

class ShopUpdateUserErrorState extends ShopStates {
  final String error ;

  ShopUpdateUserErrorState(this.error);
}

class ShopProductDetailsLoadingState extends ShopStates {}

class ShopProductDetailsSuccessfulState extends ShopStates {}

class ShopProductDetailsErrorState extends ShopStates {}