import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi extends GetxController{
  static final _googleSignIn = GoogleSignIn();
  final user = ''.obs;

  static Future<GoogleSignInAccount?> login()=> _googleSignIn.signIn();
  static Future logout() => _googleSignIn.disconnect();
  static Future isLogin()=> _googleSignIn.isSignedIn();
}