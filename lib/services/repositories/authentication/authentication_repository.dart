// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth;
  GoogleSignInAccount? _googleUser;
  UserModel _userModel = UserModel();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  AuthStatus _status = AuthStatus.Uninitialized;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService.instante() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    if (user == null) {
      _status = AuthStatus.Unauthenticated;
    } else {
      DocumentSnapshot userSnapshot =
          await _db.collection('users').doc(user.uid).get();
      _userModel = UserModel.fromFirestore(userSnapshot);
      _status = AuthStatus.Authenticated;
    }
    notifyListeners();
  }

  Future<UserModel?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserModel? user = (await _auth.signInWithCredential(credential)).user as UserModel?;
    return user;
  }

  void signOut() {
    _auth.signOut();
    _status = AuthStatus.Unauthenticated;
    notifyListeners();
  }

  Future<DocumentSnapshot> updateUserData(User user) async {
    DocumentReference userRef = _db.collection('users').doc(user.uid);

    userRef.set({
      'uid': user.uid,
      'email': user.email,
      'lastSign': DateTime.now(),
      'photoURL': user.photoURL,
      'displayName': user.displayName ?? user.email?.split('@')[0],
    }, SetOptions(merge: true));

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }

  AuthStatus get status => _status;
  UserModel get user => _userModel;
  GoogleSignInAccount get googleUser => _googleUser!;
}
