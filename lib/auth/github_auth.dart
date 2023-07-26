import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential> signInWithGitHub() async {
  GithubAuthProvider githubProvider = GithubAuthProvider();

  return await FirebaseAuth.instance.signInWithProvider(githubProvider);
}
