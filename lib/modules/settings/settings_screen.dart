import 'package:flutter/material.dart';
import 'package:salla/layout/state_managment/cubit.dart';
import 'package:salla/layout/state_managment/states.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/shared/common/components.dart';
import 'package:salla/shared/common/constants.dart';
import 'package:salla/shared/imports/exports.dart';
import 'package:salla/shared/styles/colors/colors.dart';

class SettingsScreen  extends StatelessWidget {

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
        listener:(context, state) {
          if(state is ShopSuccessUserDataState)
            {

              print(' nameController.text : ${nameController.text}');
              /*toast('${state.loginModel.message}',
                  toastState: ToastStates.SUCCESS);*/
            }
          else if (state is ShopErrorUserDataState)
            {
              toast('${state.error}',
                  toastState: ToastStates.ERROR);
            }
          if(state is ShopUpdateUserSuccessfulState)
            {
              if(state.loginModel.status!)
                {
                  toast(state.loginModel.message!,
                      toastState: ToastStates.SUCCESS);
                }
              else
                {
                  toast(state.loginModel.message!,
                      toastState: ToastStates.ERROR);
                }
            }
          if(state is ShopUpdateUserErrorState)
            {
              toast(state.error.toString(),
                  toastState: ToastStates.ERROR);
            }
        },
        builder: (context, state) {
          var cubit= ShopCubit.get(context);
          nameController.text = cubit.loginModel!.data!.name;
          emailController.text = cubit.loginModel!.data!.email;
          phoneController.text = cubit.loginModel!.data!.phone;

          return ConditionalBuilder(condition: cubit.loginModel !=null,
              builder: (context) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultTextFeild(controller: emailController,
                            label: 'Email',
                            prIcon: Icons.email_outlined,
                            type: TextInputType.emailAddress,
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
                            type: TextInputType.phone,
                            validate: (value){
                              if(value!.isEmpty)
                              {
                                return 'phone must not be empty ';
                              }
                              return null ;
                            }),
                        if(state is ShopUpdateUserLoadingState)
                          const LinearProgressIndicator(),

                        SeperatorBox(),
                        defaultButton(text: 'UPDATE' , color: lightModeColor ,function: (){
                          if(formKey.currentState!.validate())
                          {
                            cubit.updateUserData(name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        }),
                        SeperatorBox(),
                        defaultButton(text: 'LOGOUT' , color: lightModeColor ,function: (){
                          signOut(context);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
        });
  }
  Widget SeperatorBox() =>const SizedBox(height: 20.0,) ;
}