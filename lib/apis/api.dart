import 'package:ct240_doan/consts/firebase_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
class API{
  static void handleGoogleSignIn()
  {
    FirebaseAuth auth=FirebaseAuth.instance;
    try{
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      auth.signInWithProvider(googleAuthProvider);
    }
    catch(e)
    {
      print('error');
    }
  }
}