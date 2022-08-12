import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla/layout/state_managment/cubit.dart';
import 'package:salla/layout/state_managment/states.dart';
import 'package:salla/models/catergories_model.dart';
import 'package:salla/models/home_model.dart';
import 'package:salla/shared/imports/exports.dart';
import 'package:salla/shared/styles/colors/colors.dart';

import '../product_details/product_details_screen.dart';

class ProductsScreen  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state) {

      },
    builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(condition: cubit.dataModel != null,
            builder: (context) => cubit.dataModel != null ? productsBuilder(cubit.dataModel! , context) : const Center(
              child: Text('no data '),
            ),
            fallback:(context) => const Center(
              child: CircularProgressIndicator(),
            ));
    },
    );
  }
Widget productsBuilder(DataModel model , context) {
      return SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CarouselSlider(items: model.bannersModel.map((e) {
              return buildBanner(e.image);
            }).toList(),
                options: CarouselOptions(
                      scrollDirection: Axis.horizontal ,
                  viewportFraction: 1.0 ,
                  autoPlay: true ,
                  autoPlayAnimationDuration: const Duration(seconds: 1)  ,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true ,
                )) ,
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Categories' ,
                style: Theme.of(context).textTheme.headline1,

              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              height: 120.0,
              child: ListView.separated(itemBuilder:(context , index )=> buildCategory(ShopCubit.get(context).categoryModel!.dataModel!.catergories![index]),
                  separatorBuilder: (context , index ) => const SizedBox(width: 5.0),
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: ShopCubit.get(context).categoryModel!.dataModel!.catergories!.length),
            ) ,
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'New Products' ,
                style: Theme.of(context).textTheme.headline1,

              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(crossAxisCount: 2 ,
              shrinkWrap: true,
              physics:const NeverScrollableScrollPhysics() ,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.8,
              children: List.generate(model.productsModel.length,
                      (index) {
                         return buildProducts(model.productsModel[index] ,context);
                      }),
              ),
            ),
          ],
        ),
      );
  }
Widget buildBanner(String urlImage) => Image(
  width: double.infinity,
  image: NetworkImage('${urlImage}'),
  fit: BoxFit.cover,
);

Widget buildProducts(ProductsModel model, context) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          splashColor: lightModeColor,
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: model,)) );
            print('Inkwell : ${model.name}');
          },

          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model.image}'),
                    width: double.infinity,
                    height: 200.0,
                  ),
                  if(model.discount != 0 )
                    Container(
                      color:Colors.red,
                      padding: EdgeInsets.only(left: 10.0 , right: 5.0),
                      child: Text(
                        'Discount' ,
                        style: TextStyle(

                          fontSize: 16.0 ,
                          color: Colors.white
                        ),
                      ),
                    ),

                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(model.name ,

                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis
                  )
              ) ,
              const SizedBox(height: 10.0,),
            ],
          ),
        ) ,

        const Spacer(),
        Row(
          children: [
            Text('${model.price}' ,
            style: const TextStyle(
              color: lightModeColor ,
            ),
            ),
            const SizedBox(width: 5.0),
            if(model.discount != 0 )
            Text(
                '${model.oldPrice}' ,
              style: const TextStyle(
                color: Colors.grey ,
                decoration: TextDecoration.lineThrough
              ),
            ) ,
            const Spacer(),
            IconButton(onPressed: (){
                ShopCubit.get(context).changeFavorite(model.id);
            },padding: EdgeInsets.zero,
             icon: CircleAvatar(
              radius: 18.0,
              backgroundColor: ShopCubit.get(context).favorites['${model.id}']! ? lightModeColor : Colors.grey,
              child: Icon(
                Icons.favorite_outline ,
                color: Colors.white,
                size: 18.0,
              ),
            ))
          ],
        ),
      ],
    ),
  );
}

Widget buildCategory(CategoryData model) =>Container(
  padding: EdgeInsets.all(10.0) ,
  height: 120.0,
  width: 120.0,
  child:   Stack(
    alignment: AlignmentDirectional.bottomCenter,

    children: [

      Image(

        image: NetworkImage('${model.image}'),



        fit: BoxFit.cover,



      ),

      Container(

        width: double.infinity,

        color: Colors.black.withOpacity(0.8),

        child: Text(
            '${model.name}',
           textAlign: TextAlign.center,
           style: TextStyle(
             color: Colors.white,
             fontSize: 14.0
           ),

        ),

      ),

    ],

  ),
) ;
}
