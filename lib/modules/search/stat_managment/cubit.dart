import 'package:salla/models/search_model.dart';
import 'package:salla/modules/search/stat_managment/state.dart';
import 'package:salla/shared/network/remote/end_points.dart';

import '../../../shared/common/constants.dart';
import '../../../shared/imports/exports.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<SearchStates>{
  ShopSearchCubit() : super(SearchInitialStates());

  static ShopSearchCubit get(context) => BlocProvider.of(context);
  SearchProducts? searchModel ;
  void search (String text)
  {
    emit(SearchLoadingStates());
    DioHelper.postData(path: SEARCH_PRODUCTS ,
        authorization: token ,
        data: {
          'text' : text
        }
    ).then((value) {
      print('Data of Search : ${value.data}');
      searchModel = SearchProducts.fromJson(json:value.data );
      emit(SearchSuccessStates());

    }).catchError((onError){
      print(onError);
      emit(SearchErrorStates());
    });
  }
}