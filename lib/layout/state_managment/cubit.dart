import 'package:flutter/cupertino.dart';
import 'package:salla/layout/state_managment/states.dart';
import 'package:salla/models/catergories_model.dart';
import 'package:salla/models/favorites_model.dart';
import 'package:salla/models/home_model.dart';
import 'package:salla/models/shop_login_model.dart';
import 'package:salla/modules/categories/categories_screen.dart';
import 'package:salla/modules/favorites/favorite_screen.dart';
import 'package:salla/modules/products/products_screen.dart';
import 'package:salla/modules/settings/settings_screen.dart';
import 'package:salla/shared/common/constants.dart';
import 'package:salla/shared/imports/exports.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';
import 'package:salla/shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0 ;

  List<Widget> screens = [
    ProductsScreen() ,
    CategoriesScreen() ,
    FavoritesScreen() ,
    SettingsScreen(),
  ];
  void changeNavBottom(int index)
  {
    currentIndex = index ;
    emit(ShopChangeNavBottomState());

  }
  DataModel? dataModel ;
  void getHomeData()async
  {
      emit(ShopHomeLoadingState());
      var value = await DioHelper.getData(
          path: HOME,
          authorization: token,
      ).catchError((error){
        emit(ShopHomeErrorState(error.toString()));
      });
      /*print(value.data['data']['products'][0]);*/
      HomeModel model = HomeModel.fromJson(value.data);
      model.data!.productsModel.forEach((element) {
        favorites.addAll({
          '${element.id}' : element.inFavorites
        });
      });
      if(model.status!)
        {
          dataModel = model.data!;
          emit(ShopHomeSuccessfulState());
        }
      else
        {
          emit(ShopHomeErrorState('Status Error : ${model.status}'));
        }

  }

  CategoryModel? categoryModel;
  void getCategories()
  {
    emit(ShopGetCategoriesLoadingState());
    DioHelper.getData(path: CATERGORIES , 
    
    ).then((value) {
      categoryModel = CategoryModel.fromJson(json: value.data);
      emit(ShopGetCategoriesSuccessfulState());
    }).catchError((error){
      emit(ShopGetCategoriesErrorState(error));
    });
  }
  late FavoriteModel favoriteModel;
  void getFavorites()
  {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(path: FAVORITES ,
        authorization: token ).then((value) {
      /*print("FavroiteModel : ${value.data}");*/
      favoriteModel = FavoriteModel.fromJson(value.data);

      emit(ShopGetFavoritesSuccessfulState());
    }).catchError((error){
      print('Error : ${error.toString()}');
      emit(ShopGetFavoritesErrorState(error.toString()));
    }) ;
  }

  Map<String , bool> favorites = {};
  void changeFavorite(int id)
  {
      favorites['${id}'] = !favorites['${id}']!;
      emit(ShopChangeFavSuccessfulState());

      /*print('Favorites : ${favorites['${id}']}');*/
      DioHelper.postData(path: FAVORITES ,
      data: {
        'product_id':id
      } ,
        authorization: token ,
      ).then((value) {
        print(value.data['status']);
        if(!value.data['status'])
          {
            favorites['${id}'] = !favorites['${id}']!;
          }
        else
          {
            getFavorites();
          }
        emit(ShopChangeFavSuccessfulState());
      }).catchError( (error) {
        favorites['${id}'] = !favorites['${id}']!;
        emit(ShopGetFavoritesErrorState(error));
      });
  }

  ShopLoginModel? loginModel;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(path: PROFILE ,
    authorization: token,
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print('Login mODLE : ${loginModel!.status!}');
      emit(ShopSuccessUserDataState(loginModel!));
    }).catchError((error){
      emit(ShopErrorUserDataState(error.toString()));
    });
  }
  void updateUserData({
  required String name ,
  required String email ,
  required String phone ,
})
  {
    emit(ShopUpdateUserLoadingState());
    DioHelper.putData(path: UPDATE_PROFILE,
        authorization: token ,
        data: {
          'name':'${name}' ,
          'email':'${email}' ,
          'phone':'${phone}' ,
        }
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopUpdateUserSuccessfulState(loginModel!));
    }).catchError((error) {
      emit(ShopUpdateUserErrorState(error));
    });
  }
  void getProductDetails({
  required int id 
}){
    emit(ShopProductDetailsLoadingState());
    
    DioHelper.getData(path: PRODUCT_DETAILS ,
    authorization: token ,
    queryParameters: {
      'id':id
    }
    ).then((value) {

    }).catchError((onError) {

    });
  }
}