import 'package:flutter/material.dart';
import 'package:salla/layout/state_managment/cubit.dart';
import 'package:salla/layout/state_managment/states.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/shared/imports/exports.dart';
import 'package:salla/shared/styles/colors/colors.dart';

import '../../models/favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state) {
        if(state is ShopGetFavoritesErrorState)
          {
            toast(state.error.toString(),
                toastState: ToastStates.ERROR);
          }
      },
      builder: (context , state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(condition: cubit.favoriteModel.data!.favorites.isNotEmpty,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildFavoriteItem(cubit.favoriteModel.data!.favorites[index].product! , context ),
                separatorBuilder: (context , index )=> Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  height: 1.0,
                ),
                itemCount: cubit.favoriteModel.data!.favorites.length),
            fallback:(context) => const Center(
              child: Text(
                'you have no favorites' ,
              ),
            ));
      },
    );
  }
   Widget buildFavoriteItem (Product model , context) =>   Container(
     height: 120.0,

     child: Row(
      
       mainAxisAlignment: MainAxisAlignment.start,

       children: [
         Container(
           height: 120.0,
           width: 120.0,
           child: Stack(

             alignment: AlignmentDirectional.bottomStart,
             children: [
               Image(
                 image: NetworkImage('${model.image}'),
                 width: double.infinity,

               ),
               if (model.discount != 0)
                 Container(
                   color: Colors.red,
                   padding: EdgeInsets.only(left: 10.0, right: 5.0),
                   child: Text(
                     'Discount',
                     style: TextStyle(fontSize: 16.0, color: Colors.white),
                   ),
                 )
             ],
           ),
         ),
         SizedBox(
           width: 5.0,
         ),
         Expanded(
           child: Column(
             children: [
               Expanded(
                 child: Text('${model.name}',
                     maxLines: 3,
                     style: const TextStyle(
                         fontSize: 14.0,
                         color: Colors.black,
                         fontWeight: FontWeight.bold,
                         overflow: TextOverflow.ellipsis)),
               ),
               const SizedBox(
                 height: 10.0,
               ),

               Row(
                 children: [
                   Text(
                     '${model.price}',
                     style: const TextStyle(
                       color: lightModeColor,
                     ),
                   ),
                   const SizedBox(width: 5.0),
                   if (model.discount != 0)
                     Text(
                       '${model.oldPrice}',
                       style: const TextStyle(
                           color: Colors.grey, decoration: TextDecoration.lineThrough),
                     ),
                   const Spacer(),
                   IconButton(
                       onPressed: () {
                         ShopCubit.get(context).changeFavorite(model.id!);
                       },
                       padding: EdgeInsets.zero,
                       icon: CircleAvatar(
                         radius: 18.0,
                         backgroundColor: ShopCubit.get(context).favorites['${model.id}']! ? lightModeColor : Colors.grey,
                         child: Icon(
                           Icons.favorite_outline,
                           color: Colors.white,
                           size: 18.0,
                         ),
                       ))
                 ],
               ),
             ],
           ),
         )
       ],
     ),
   );
}
