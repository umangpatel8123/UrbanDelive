import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbandelive/models/user_model.dart';
import 'package:urbandelive/screens/otp_screen.dart';
import 'package:urbandelive/utils/utils.dart';

import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthProvider() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool('is_signedin') ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool('is_signedin', true);
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          _isLoading = false;
          notifyListeners();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(verificationId: verificationId),
            ),
          );
        },
        timeout: const Duration(seconds: 25),
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      showSnackBar(context, "Please enter a valid phone number");
      _isLoading = false;
      notifyListeners();
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser() async {
    var url = Uri.parse("http://127.0.0.1:8000/checkUser/");
    Map body = {"uid": _uid};
    http.Response response = await http.post(
      url,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    dynamic res = jsonDecode(response.body);
    if (res["existing_user"]) {
      return true;
    } else {
      return false;
    }
  }

  void saveUserDataToDjango({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading data to Django
      // var url = Uri.parse("http://127.0.0.1:8000/createUser/");
      // Map body = {"uid": _uid};
      // http.Response response = await http.post(
      //   url,
      //   body: jsonEncode(body),
      //   headers: {'Content-Type': 'application/json'},
      // );
      // dynamic res = jsonDecode(response.body);

      // await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
      //   userModel.profilePic = value;
      //   userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      //   userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      //   userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      // });
      // _userModel = userModel;

      // uploading to database
      // await _firebaseFirestore
      //     .collection("users")
      //     .doc(_uid)
      //     .set(userModel.toMap())
      //     .then((value) {
      //   onSuccess();
      _isLoading = false;
      notifyListeners();
      // });
    } on FirebaseAuthException catch (e) {
      // showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> getDataFromDjango({required BuildContext context}) async {
    var url = Uri.parse("http://127.0.0.1:8000/getUser/");
    Map body = {"uid": _uid};
    http.Response response = await http.post(
      url,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    dynamic res = jsonDecode(response.body);
    bool ans = res["error"];
    if (!ans) {
      // save to user model
      dynamic resUser = res["user"];
      _userModel = UserModel(
        uid: resUser['user']['uid'],
        username: resUser['user']['username'],
        email: resUser['user']['email'],
        phoneNo: resUser['user']['phoneNo'],
        createdAt: resUser['user']['date_joined'],
        lastLogin: resUser['user']['last_login'],
        dob: resUser['dob'],
        bio: resUser['bio'],
        addressLine1: resUser['addressLine1'],
        addressLine2: resUser['addressLine2'],
      );
      _uid = userModel.uid;
      return true;
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, res["msg"]);
      return false;
    }
  }

  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }
}
