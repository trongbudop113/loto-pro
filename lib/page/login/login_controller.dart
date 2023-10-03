import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page_config.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class LoginController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> onClickLogin() async {
    var user = await signInWithGoogle();
    await saveUserInfo(user);
    Get.offNamed(PageConfig.MENU);
  }

  Future<void> onClickLoginEmail() async {
    if(userNameController.text.isEmpty && passwordController.text.isEmpty){
      return;
    }
    var user = await signInWithEmail();
    await saveUserInfo(user);
    Get.offNamed(PageConfig.MENU);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithEmail() async {
    final email = userNameController.text;
    final password = passwordController.text;

    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  Future<void> saveUserInfo(UserCredential user) async {
    try{
      CollectionReference usersReference = firestore.collection(DataRowName.Users.name);
      final getUSer = await usersReference.doc(user.user?.email ?? '').get();
      if(!getUSer.exists){
        UserLogin userLogin = UserLogin();
        userLogin.email = user.user?.email ?? '';
        userLogin.name = user.user?.displayName ?? '';
        userLogin.uuid = user.user?.uid ?? '';
        userLogin.createTime = DateTime.now().millisecondsSinceEpoch;
        userLogin.updateTime = DateTime.now().millisecondsSinceEpoch;
        userLogin.lastSignInTime = DateTime.now().millisecondsSinceEpoch;
        userLogin.avatar = user.user?.photoURL ?? '';
        userLogin.joinRoomID = '';
        userLogin.isAdmin = false;

        await usersReference.doc(user.user?.email ?? '').set(userLogin.toJson());
      }else{
        await usersReference.doc(user.user?.email ?? '').update({
          "lastSignInTime":
          DateTime.now().millisecondsSinceEpoch,
        });
      }
    }catch(e){
      e.printInfo(info: "saveUserInfo");
    }
  }

}