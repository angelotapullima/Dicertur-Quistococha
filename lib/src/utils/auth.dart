import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dicertur_quistococha/src/utils/dialogs.dart';
import 'package:dicertur_quistococha/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Auth {
  Auth._internal();

  static Auth get instance => Auth._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /* String name;
  String email;
  String imageUrl; */

  User? get user {
    //metodo asyncrono que devuelve los datos de firebase
    return (_firebaseAuth.currentUser!);
  }

  //Auth von Google
  Future<UserSign> signInWithGoogle(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();

      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final User user = (await _firebaseAuth.signInWithCredential(credential)).user!;
      //print(user.providerData[1].email);

      final User currentUser = _firebaseAuth.currentUser!;
      assert(user.uid == currentUser.uid);

      print('firebase client ${user.displayName}');

      UserSign userSign = UserSign();
      userSign.emailAddress = user.email;
      userSign.name = user.displayName;
      userSign.phone = user.phoneNumber;
      userSign.photo = user.photoURL;
      progressDialog.dismiss();

      return userSign;
    } catch (e) {
      print(e);
      UserSign userSign = UserSign();
      userSign.emailAddress = '';
      userSign.name = '';
      userSign.phone = '';
      userSign.photo = '';
      progressDialog.dismiss();
      return userSign;
    }
  }

  String generateNonce([int length = 32]) {
    final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserSign> signInWithApple(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final identityToken = appleCredential.identityToken;

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      progressDialog.dismiss();
      User user = (await _firebaseAuth.signInWithCredential(oauthCredential)).user!;

      UserSign appleSign = UserSign();
      if (identityToken != null) {
        final data = JwtDecoder.decode(identityToken);

        print(data);

        final email = data['email'].toString();

        appleSign.emailAddress = email;
        appleSign.name = user.displayName;
      } else {
        appleSign.emailAddress = '';
        appleSign.name = '';
      }

      return appleSign;
    } on SignInWithAppleAuthorizationException {
      print('Usuario cancelo');
      progressDialog.dismiss();
      showToast2('Usuario cancelo', Colors.amber);
      UserSign userSign = UserSign();
      userSign.emailAddress = '';
      userSign.name = '';
      userSign.phone = '';
      userSign.photo = '';
      progressDialog.dismiss();
      return userSign;
    } on FirebaseAuthException catch (e) {
      print(e);
      showToast2(e.toString(), Colors.amber);
      UserSign userSign = UserSign();
      userSign.emailAddress = '';
      userSign.name = '';
      userSign.phone = '';
      userSign.photo = '';
      progressDialog.dismiss();
      return userSign;
    }
  }

  Future<bool> get isAvalableApple {
    return SignInWithApple.isAvailable();
  }

  Future<void> logOut(BuildContext context) async {
    final data = (user!).providerData;
    String providerId = "firebase";

    for (final provider in data) {
      if (provider.providerId != 'firebase') {
        providerId = provider.providerId;
        break;
      }
    }

    switch (providerId) {
      case "google.com":
        await _firebaseAuth.signOut();
        await _googleSignIn.signOut();
        break;
      case "password":
        break;
      case "phone":
        break;
    }

    await _firebaseAuth.signOut();

    Navigator.pushNamedAndRemoveUntil(context, 'splash', (_) => false);
  }
}

class UserSign {
  String? emailAddress;
  String? name;
  String? phone;
  String? photo;

  UserSign({
    this.emailAddress,
    this.name,
    this.phone,
    this.photo,
  });
}
