import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salla/layout/state_managment/cubit.dart';
import 'package:salla/models/favorites_model.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/shared/common/components.dart';
import 'package:salla/shared/styles/colors/colors.dart';

import '../../models/home_model.dart';

class ProductDetailsScreen extends StatelessWidget {

  final ProductsModel product;
  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white
        ),
      ),
    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage('${product.image}'),
          ),
          Text(
            '${product.name}' ,
            style: Theme.of(context).textTheme.bodyText1,
          ) ,
          Spacer() ,
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: lightModeColor , 
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: MaterialButton(onPressed: (){

              product.inCart = !product.inCart ;
              var cubit = ShopCubit.get(context);
              for(int i= 0 ; i < cubit.dataModel!.productsModel.length ; i++)
                {
                  if(cubit.dataModel!.productsModel[i].id == product.id)
                    {
                      cubit.dataModel!.productsModel[i] = product;
                      break;
                    }
                }
              if(product.inCart)
              {
                toast('added to cart', toastState: ToastStates.SUCCESS);
              }
              else
              {
                toast('Removed from cart', toastState: ToastStates.SUCCESS);
              }
            } ,
              child: Text(
               product.inCart ? 'Add to Cart ' : 'Added to cart' ,
              style: TextStyle(
                color: Colors.white ,
                fontSize: 16.0 ,
                fontWeight: FontWeight.bold
              ),
            ),
            ),
          )
        ],
      ),
    )
    );
  }
}
