import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<void> nativeGoogleSignIn(
    void Function(String? username, String? photoUrl, String? email)
        handleLoginAction) async {
  const webClientId =
      '383717383782-6r4gtlqdl2tg6d2teja8vqia4bbivnjp.apps.googleusercontent.com';

  const iosClientId =
      '383717383782-8869kngglrhopbo9kv4sg4268r306qq3.apps.googleusercontent.com';

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: iosClientId,
    serverClientId: webClientId,
  );
  final googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser!.authentication;
  final accessToken = googleAuth.accessToken;
  final idToken = googleAuth.idToken;

  

  if (accessToken == null) {
    throw 'No Access Token found.';
  }
  if (idToken == null) {
    throw 'No ID Token found.';
  }

  await supabase.auth.signInWithIdToken(
    provider: OAuthProvider.google,
    idToken: idToken,
    accessToken: accessToken,
  );

  handleLoginAction(
      googleUser.displayName, googleUser.photoUrl, googleUser.email);
}
