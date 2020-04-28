import 'package:flutter/widgets.dart';
import 'package:homesweethome/screens/email/register.dart';
import 'package:homesweethome/screens/email/sign_in_wit_email.dart';


class Authenticate extends StatefulWidget{


  @override
  _AuthenticateState  createState()=> _AuthenticateState();


}
class _AuthenticateState extends State<Authenticate>{

  bool isSingIn =true;
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {

   if(isSingIn){
       return SignInWithEmail();
   }
   else{
     return Register();
   }
  }
}