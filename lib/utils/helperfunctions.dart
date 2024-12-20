import 'package:blogs_app/auth/ui/signup_screen.dart';
import 'package:blogs_app/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  Future<void> saveLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.isLoggedIn, isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.isLoggedIn) ?? false;
  }

  Future<void> clearLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.isLoggedIn);
  }

  Future<void> setUserId(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.userId, userId);
  }

  Future<int?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(AppConstants.userId);
  }

  Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.userId);
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      // Prevent dismissing the dialog by tapping outside
      builder: (context) => Center(
        child: Card(
          elevation: 2,
          child: Container(
            width: 75.0,
            height: 75.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator.adaptive()),
            ),
          ),
        ),
      ),
    );
  }

  void dialogFunction(
      BuildContext context, String title, String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("Yes"),
              onPressed: () {
                onConfirm(); // Execute the callback function
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

    //Clear isLoggedIn record from Shared Preference
    HelperFunctions().clearLoginStatus();
    HelperFunctions().clearUserId();

    //Clear all the previous route and redirect user to logout screen
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
        (route) => false);
  }

  Future<User?> signInWithGoogle() async {
    try {
      // Initialize GoogleSignIn
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Attempt to sign in the user
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Retrieve the Google authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user; // Return the signed-in user
    } catch (error) {
      print("Error during Google Sign-In: $error");
      return null;
    }
  }

  void showCustomBottomSheet(BuildContext context, VoidCallback onEdit, VoidCallback onDelete) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Actions'),
          message: const Text('Choose an action for the blog'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
                onEdit(); // Call the Edit callback
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.pencil, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Edit', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
                onDelete(); // Call the Delete callback
              },
              isDestructiveAction: true,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.trash, color: CupertinoColors.destructiveRed),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: CupertinoColors.destructiveRed)),
                ],
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context); // Close the bottom sheet
            },
            child: const Text('Cancel'),
          ),
        );
      },
    );
  }
}
