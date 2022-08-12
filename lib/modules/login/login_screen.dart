import 'package:flutter/material.dart';
import 'package:salla/layout/shop_layout.dart';
import 'package:salla/modules/login/stat_managment/cubit.dart';
import 'package:salla/modules/login/stat_managment/states.dart';
import 'package:salla/modules/register/register_screen.dart';
import 'package:salla/shared/common/components.dart';
import 'package:salla/shared/imports/exports.dart';
import 'package:salla/shared/styles/colors/colors.dart';
import 'package:salla/shared/styles/themes/themes.dart';

class LoginScreen extends  StatelessWidget {

  var emailController = TextEditingController() ;
  var passwordController = TextEditingController() ;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ShopLoginCubit() ,
    child: BlocConsumer<ShopLoginCubit , ShopLoginStates>(
      listener: (context , state) {

        if(state is ShopLoginSuccessfulState)
          {
            if(state.loginModel.status! )
              {
                print(state.loginModel.status);
                toast(state.loginModel.message.toString() ,
                toastState: ToastStates.SUCCESS,
                gravity: ToastGravity.BOTTOM ,
                );
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context)=> ShopLayout()),
                        (route) => false);
              }
            else
              {
                toast(state.loginModel.message.toString() ,
                  toastState: ToastStates.ERROR,
                  gravity: ToastGravity.BOTTOM ,
                );
              }
            /*var snackBar = const SnackBar(
              content: Text(
                'LOGIN Successful' ,

              ),
              duration: Duration(
                seconds: 2
              ),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
          }
        else if (state is ShopLoginErrorState)
          {
            toast(state.error.toString() ,
            toastState: ToastStates.WARNING,
            gravity: ToastGravity.BOTTOM ,
            );
          }
      },
      builder: (context , state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN' ,
                        style: Theme.of(context).textTheme.headline1,
                      ) ,
                      const SizedBox(height: 20.0),
                      Text('Login now to browse our hot offers' ,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 20.0,),
                      defaultTextFeild(controller: emailController,
                          prIcon: Icons.email_outlined,
                          label: 'Email',
                          type: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'you should enter email address';
                            }
                            return null;
                          }) ,
                      const SizedBox(height: 20.0,),
                      defaultTextFeild(controller: passwordController,
                          label: 'Password',
                          prIcon: Icons.lock_outline_sharp,
                          sfIcon: ShopLoginCubit.get(context).icon,
                          onSubmit: (value){
                            FocusManager.instance.primaryFocus?.unfocus();
                            if(formKey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text ,
                                  password: passwordController.text
                              );
                            }
                          },
                          suffixpressed: (){
                            ShopLoginCubit.get(context).changeVisibility();
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          type: TextInputType.visiblePassword,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'you should enter password';
                            }
                            return null;
                          }) ,
                      const SizedBox(height: 20.0),
                      ConditionalBuilder(condition: state is! ShopLoginLoadingState ,
                          builder:(context) => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: lightModeColor,
                            ),
                            child: MaterialButton(onPressed: (){
                              FocusManager.instance.primaryFocus?.unfocus();
                              if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text ,
                                    password: passwordController.text
                                  );
                                }
                            } ,
                              child: const Text(
                                  'LOGIN'
                              ),
                            ),
                          ),
                          fallback:(context) =>  const Center(child: CircularProgressIndicator())),
                      const SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account ? '),
                          TextButton(onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>RegisterScreen())
                              );
                          } ,
                            child: Text(
                              'REGISTER' ,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: lightModeColor
                              ),
                            ),
                          )
                        ],
                      )
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
}
void toast(String msg ,{
  required ToastStates toastState ,
  Toast toastLength = Toast.LENGTH_SHORT ,
  ToastGravity gravity = ToastGravity.BOTTOM,

} )
{
  Fluttertoast.showToast(
      msg: "${msg}",
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: pickColor(toastState),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum ToastStates {SUCCESS , ERROR , WARNING}

Color pickColor(ToastStates toastStates)
{
  switch(toastStates)
  {
    case ToastStates.SUCCESS : return Colors.green;
    case ToastStates.ERROR : return Colors.red;
    case ToastStates.WARNING : return Colors.yellowAccent;

  }
}