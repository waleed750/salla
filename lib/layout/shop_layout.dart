import 'package:flutter/material.dart';
import 'package:salla/layout/state_managment/cubit.dart';
import 'package:salla/layout/state_managment/states.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/modules/search/search_screen.dart';
import 'package:salla/shared/imports/exports.dart';
import 'package:salla/shared/network/local/cash_helper.dart';
import 'package:salla/shared/styles/colors/colors.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state) {

      },
      builder: (context , state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
                'Salla'
            ),
            actions: [
              IconButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>SearchScreen() ));
              }, icon: const Icon(
                  Icons.search
              )),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: lightModeColor,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeNavBottom(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(
                Icons.home ,
              ),
                label: 'Home' ,
              ),
              BottomNavigationBarItem(icon: Icon(
                Icons.apps_outlined ,
              ),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(icon: Icon(
                Icons.favorite,
              ),
                  label: 'Favorites',
              ),
              BottomNavigationBarItem(icon: Icon(
                Icons.settings ,
              ),

                  label: 'Settings'
              ),
            ],
          ),
        );
      },
    ) ;
  }
}
