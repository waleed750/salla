

import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity ,
  Color color = Colors.blue ,
  VoidCallback? function ,
  required String text ,
  bool isUpperCase = true ,
}) =>Container(
  width : width,
  child: MaterialButton(
    onPressed: function ,
    child: Text( isUpperCase ? text.toUpperCase() : text ,
      style: TextStyle(
          color: Colors.white
      ),),

  ) ,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0) ,
    color: color ,
  ),
);

Widget defaultTextFeild(
{
  required TextEditingController controller ,
  bool enable = true ,
  required TextInputType type ,
  Function? onSubmit  ,
  Function(String? s)? onChange ,
  IconData? prIcon,
  IconData? sfIcon ,
  Function? onTap ,
  bool isPassword = false ,
  VoidCallback? suffixpressed ,
  required String? Function(String? value)? validate ,
  String? label ,
  FocusNode? focusNode,
  TextInputAction? textInputAction,
}
    ) =>  TextFormField(
  controller: controller,
   textInputAction: textInputAction,
  focusNode:  focusNode,
  enabled: enable,
  onTap: ()
  {
    onTap != null? onTap() : null ;
  },
  keyboardType: type ,
  onFieldSubmitted: (value){
    onSubmit!= null? onSubmit(value) : null;
  } ,

  onChanged:(value){
    if(onChange != null)
      {
       onChange(value);
      }
  },
  obscureText: isPassword,
  decoration: InputDecoration(

    labelText: label ,
    prefixIcon:Icon( prIcon),
    suffixIcon:  sfIcon != null ? IconButton(
            onPressed: suffixpressed,
            icon: Icon (sfIcon )) : null,
    border: OutlineInputBorder(
        borderSide: BorderSide(
            style: BorderStyle.solid
        )
    )  ,
  ),
  validator: validate ,
) ;


BottomNavigationBarItem defaultNavigationBar (
{
  required String label ,
  required IconData icon ,
  Function? onPressed ,
}
    )=>  BottomNavigationBarItem(
  label: label,

  icon: Icon(
      icon
  ),
) ;

void pushAndDelete( context, {
     required Widget to ,
     noRoute = false,
}) => Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder:
        (context) =>  to
    ), (route) => noRoute);





