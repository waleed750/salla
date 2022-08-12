import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/modules/onboarding/model/boarding_model.dart';
import 'package:salla/shared/common/components.dart';
import 'package:salla/shared/imports/exports.dart';
import 'package:salla/shared/network/local/cash_helper.dart';

class OnBoardingScreen extends StatefulWidget {


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardingController = PageController();
  var index = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
           TextButton(
               onPressed: (){
                 CashHelper.setData(key: 'onBoarding',
                     value: false);
                 pushAndDelete(context,
                     to: LoginScreen());
                 setState(() {

                 });
               },
               child: Text('Skip'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(itemBuilder: (context, index) => buildBoardItem(BoardingModel.boardingList[index] , index),
               controller: boardingController,
               physics: BouncingScrollPhysics(),
                itemCount: BoardingModel.boardingList.length,
              ),
            ),
            const SizedBox(height:50.0 ,),
            SmoothPageIndicator(
              effect: WormEffect(
                 activeDotColor: Theme.of(context).primaryColor ,

              ),
              controller: boardingController,
                count: BoardingModel.boardingList.length )
          ],
        ),
      )
      ,
    );
  }
  Widget buildBoardItem(BoardingModel model,int  index ) => Column(

    children: [
      Expanded(

        child: Image(

          image : AssetImage('${model.image}'),
          fit: BoxFit.fitWidth,
        ),
      ) ,
      SizedBox(height: 50.0,),
      Text(
        '${model.title.toUpperCase()}' ,
        style: Theme.of(context).textTheme.headline5,
      ) ,
      Text(
        '${model.body}' ,
        style: Theme.of(context).textTheme.bodyText1,
      ) ,
      SizedBox(height: 50.0,),
      MaterialButton(onPressed: (){
        setState (() {
          if(index == BoardingModel.boardingList.length -1 )
          {
               CashHelper.setData(key: 'onBoarding',
                   value: false);
                pushAndDelete(context,
                    to: LoginScreen());

          }
          else {
            boardingController.nextPage(
              duration: const Duration(
                  seconds: 1
              ), curve: Curves.fastLinearToSlowEaseIn,

            );
          }
        });

      } ,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0) ,
          ),
          color: Colors.deepOrange,

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${  index != BoardingModel.boardingList.length - 1 ? 'NEXT' : 'FINISH'}' ,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white ,
                    fontSize: 25.0
                ),
              ),
              const SizedBox(width: 10.0,),
              const Icon(
                Icons.arrow_forward_ios ,
                color: Colors.white,
              )
            ],
          )
      ) ,

    ],
  ) ;
}
