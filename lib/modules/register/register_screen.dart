import 'package:flutter/material.dart';
import 'package:salla/layout/shop_layout.dart';
import 'package:salla/layout/state_managment/cubit.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/modules/register/stat_managment/cubit.dart';
import 'package:salla/modules/register/stat_managment/states.dart';
import 'package:salla/shared/common/components.dart';
import 'package:salla/shared/imports/exports.dart';
import 'package:salla/shared/network/local/cash_helper.dart';
import 'package:salla/shared/styles/colors/colors.dart';

import '../../shared/common/constants.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ShopRegisterCubit() ,
    child: BlocConsumer<ShopRegisterCubit ,ShopRegisterStates>(
      listener: (context , state) {

        if(state is ShopRegisterSuccessfulState)
          {
            if(state.loginModel.status!)
              {
                toast(state.loginModel.message.toString(),
                    toastState: ToastStates.SUCCESS);
                CashHelper.setData(key: 'token',
                    value: state.loginModel.data!.token).then((value) {
                      token = state.loginModel.data!.token;
                      ShopCubit.get(context).currentIndex = 0 ;
                });
                
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context){
                      return ShopLayout();
                    }),
                  (route) => false,
                );
              }
            else{
              toast(state.loginModel.message.toString(),
                  toastState: ToastStates.ERROR);
            }
          }
        else if (state is ShopRegisterErrorState)
          {
            toast(state.error.toString(),
                toastState: ToastStates.WARNING);
          }
      },
      builder: (context , state) {
        var cubit = ShopRegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(

          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'REGISTER' ,
                        style: Theme.of(context).textTheme.headline1,
                      ) ,
                      const SizedBox(height: 20.0),
                      Text('REGISTER now to browse our hot offers' ,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SeperatorBox(),
                      defaultTextFeild(controller: emailController,
                          label: 'Email',
                          prIcon: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'email must not be empty ';
                            }
                            return null ;
                          }) ,
                      SeperatorBox(),
                      defaultTextFeild(controller: nameController,
                          label: 'Name',
                          prIcon: Icons.person,
                          type: TextInputType.text,
                          textInputAction: TextInputAction.next,

                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'name must not be empty ';
                            }
                            return null ;
                          }) ,
                      SeperatorBox(),
                      defaultTextFeild(controller: phoneController,
                          label: 'phone',
                          prIcon: Icons.phone,
                          textInputAction: TextInputAction.next,

                          type: TextInputType.phone,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'phone must not be empty ';
                            }
                            return null ;
                          }),

                      SeperatorBox(),
                      defaultTextFeild(controller: passwordController,
                          label: 'Password',
                          prIcon: Icons.lock,
                          textInputAction: TextInputAction.none,
                          sfIcon: cubit.isPassword ? Icons.visibility_off : Icons.visibility ,
                          isPassword: cubit.isPassword,
                          suffixpressed: (){
                            cubit.changeVisibility();
                          },
                          type: TextInputType.visiblePassword,
                          onSubmit: (value){
                            cubit.userRegister(name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text ,
                                password: passwordController.text
                            );
                          },
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'password must not be empty ';
                            }
                            return null ;
                          }),

                      SeperatorBox(),
                      ConditionalBuilder(condition: state is! ShopRegisterLoadingState ,
                          builder: (context) => defaultButton(text: 'REGISTER' , color: lightModeColor ,function: (){
                            if(formKey.currentState!.validate())
                            {
                              cubit.userRegister(name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text ,
                                  password: passwordController.text
                              );
                            }
                          }),
                          fallback:(context) => const Center(
                            child: CircularProgressIndicator(),
                          )),
                      SeperatorBox(),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
    );
  }
  Widget SeperatorBox() =>const SizedBox(height: 20.0,) ;
}
