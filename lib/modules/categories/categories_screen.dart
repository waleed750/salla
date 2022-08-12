import 'package:flutter/material.dart';
import 'package:salla/layout/state_managment/cubit.dart';
import 'package:salla/layout/state_managment/states.dart';
import 'package:salla/models/catergories_model.dart';
import 'package:salla/shared/imports/exports.dart';

class CategoriesScreen  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>
      (listener: (context , index ) { } ,
      builder: (context , index ){
        var cubit = ShopCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
          physics: const BouncingScrollPhysics()
          ,itemBuilder: (context , index ) => buildCategoryItem(cubit.categoryModel!.dataModel!.catergories![index] , context),
              separatorBuilder: (context , index) => Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              itemCount: cubit.categoryModel!.dataModel!.catergories!.length),
        );
      },
    );
  }

  Widget buildCategoryItem(CategoryData model , context)
  {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          height: 100.0,
          width: 100.0,
        ),
        const SizedBox(width: 5.0,),
        Text('${model.name.toUpperCase()}',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 14.0 ,
          ),
        ) ,
        const Spacer(),
        IconButton(onPressed: (){

        }, icon: const Icon(
          Icons.arrow_forward_ios
        ))
      ],
    );
  }
}