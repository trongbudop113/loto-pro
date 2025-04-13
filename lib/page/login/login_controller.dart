import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loto/common/common.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/widget/loading/loading_overlay.dart';

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
  final TextEditingController otpController = TextEditingController();

  final RxBool isModePhone = false.obs;

  Future<void> onClickLogin(BuildContext context) async {
    LoadingOverlay.instance().show(context: context);
    var user = await signInWithGoogle();
    await saveUserInfo(user);
    LoadingOverlay.instance().hide();
    Get.back(result: true);
  }

  String verificationId = "";

  Future<void> onSendOTP() async {
    String phone = "+84${int.parse(userNameController.text.trim().toString())}";
    print(phone);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential).then(
              (value) => print('Logged In Successfully'),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId ?? '';
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("time out");
      },
    );
  }

  Future<UserCredential> onVerifyOTPCode() async {
    String otp = otpController.text.trim();
    print(otp);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    final user = await FirebaseAuth.instance.signInWithCredential(credential);
    return user;
  }

  Future<void> onClickLoginEmail(BuildContext context) async {
    LoadingOverlay.instance().show(context: context);
    if(isModePhone.value){
      if(otpController.text.isNotEmpty){
        var user = await onVerifyOTPCode();
        print(user.user.toString());
        await saveUserInfo(user);
        LoadingOverlay.instance().hide();
        Get.back(result: true);
      }
      return;
    }
    if(userNameController.text.isEmpty && passwordController.text.isEmpty){
      return;
    }
    var user = await signInWithEmail();
    await saveUserInfo(user);
    LoadingOverlay.instance().hide();
    Get.back(result: true);
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
      final getUSer = await usersReference.doc(user.user?.uid ?? '').get();
      if(!getUSer.exists){
        String userName = user.user?.displayName ?? '';
        if(isModePhone.value){
          userName = userNameController.text.trim();
        }

        UserLogin userLogin = UserLogin();
        userLogin.email = user.user?.email ?? '';
        userLogin.name = userName;
        userLogin.uuid = user.user?.uid ?? '';
        userLogin.createTime = DateTime.now().millisecondsSinceEpoch;
        userLogin.updateTime = DateTime.now().millisecondsSinceEpoch;
        userLogin.lastSignInTime = DateTime.now().millisecondsSinceEpoch;
        userLogin.avatar = user.user?.photoURL ?? '';
        userLogin.joinRoomID = '';
        userLogin.isAdmin = false;

        await usersReference.doc(user.user?.uid ?? '').set(userLogin.toJson());
        AppCommon.singleton.userLoginData = userLogin;
      }else{
        AppCommon.singleton.userLoginData = UserLogin.fromJson(getUSer.data() as Map<String, dynamic>);
        await usersReference.doc(user.user?.uid ?? '').update({
          "lastSignInTime":
          DateTime.now().millisecondsSinceEpoch,
        });
      }
    }catch(e){
      e.printInfo(info: "saveUserInfo");
    }
  }

  void onChangeMode(bool isMode) {
    isModePhone.value = isMode;
  }

}