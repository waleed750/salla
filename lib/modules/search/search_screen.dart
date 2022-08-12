import 'package:flutter/material.dart';
import 'package:salla/shared/styles/colors/colors.dart';

import '../../layout/state_managment/cubit.dart';
import '../../models/search_model.dart';
import '../../shared/common/components.dart';
import '../../shared/imports/exports.dart';
import 'stat_managment/cubit.dart';
import 'stat_managment/state.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, SearchStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  defaultTextFeild(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "enter text in search ";
                        }
                        return null;
                      },
                      prIcon: Icons.search,
                      label: 'Search' ,
                      onSubmit: (value){
                        ShopSearchCubit.get(context).search(value);
                      }),
                  SizedBox(height: 20,),
                  if(state is SearchLoadingStates)
                    LinearProgressIndicator(),
                  Expanded(
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => buildProductItem(ShopSearchCubit.get(context).searchModel!.data!.products[index] , context),
                        separatorBuilder:(context, index) =>  SizedBox(height:10 ),
                        itemCount:  ShopSearchCubit.get(context).searchModel != null ? ShopSearchCubit.get(context).searchModel!.data!.products.length : 0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildProductItem(ProductSearchModel product, context) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(

      height: 120.0,
      child: Row(
        children: [
          Stack(
              alignment: AlignmentDirectional.bottomStart,
              children :
              [
                Image(image: NetworkImage(
                    product.image!
                ),
                  width: 150,
                  height: 150.0,
                ),

              ]
          ),
          SizedBox(width:  10.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(product.name!,
                  style: TextStyle(
                    fontSize: 14.0 ,
                    height: 1.2 ,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ) ,
                SizedBox(
                  height: 10.0,),
                Row(
                  children: [
                    Text('${product.price!.round()} EGP' ,
                      style: TextStyle(
                          color: lightModeColor
                      ),
                    ),
                    SizedBox(width: 10.0,) ,
                    Spacer(),
                    CircleAvatar(
                      radius: 17.0 ,
                      backgroundColor: ShopCubit.get(context).favorites[product.id] == true  ? lightModeColor : Colors.grey,
                      child: IconButton(
                          onPressed: (){
                            ShopCubit.get(context).changeFavorite(
                                product.id
                            );
                          },
                          icon: Icon( Icons.favorite_border ,
                            color: Colors.white,
                            size: 16.0,
                          )
                      ),
                    ) ,

                  ],
                ),


              ],
            ),
          ),
        ],
      ),
    ),
  );
}
