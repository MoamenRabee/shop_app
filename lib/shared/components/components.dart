import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

NavigateOff(BuildContext context,Widget Screen){
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (conext) => Screen,
    ),
  );
}

NavigateTo(BuildContext context,Widget Screen){
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (conext) => Screen,
    ),
  );
}


Widget MyTextFormField({
  @required TextEditingController? controller,
  @required String? lableText,
  @required Icon? prefixIcon,
  @required bool? isPassword,
  TextInputType? keyboardType,
  Icon? suffixIcon,
  suffixFunction,
  validateFunction,
  SubmittedFunction,
}){
  return TextFormField(
    controller: controller,
    validator:validateFunction,
    obscureText: isPassword!,
    keyboardType: keyboardType ?? TextInputType.text,
    onFieldSubmitted: SubmittedFunction,
    decoration: InputDecoration(
      labelText: lableText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon != null ? IconButton(
        onPressed: suffixFunction,
        icon: suffixIcon,
      ) : null,
      border: InputBorder.none,
      labelStyle: TextStyle(
        color: Colors.black45,
      ),
      fillColor: Colors.grey[200],
      filled: true,

    ),

  );
}


Future<bool?> ShowToast({
  @required String? msg,
  Color backgroundColor = Colors.black45,
  Color textColor = Colors.white
}){
  return Fluttertoast.showToast(
      msg: "${msg}",
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0
  );
}