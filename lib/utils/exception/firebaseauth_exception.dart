class BFirebaseAuthException implements Exception {
  final String code;

  BFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email';
      case 'weak-password':
        return 'The Password is too weak. Please choose a stronger password.';
      case 'user-disable':
        return 'This user account has been disable. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details.User not found';
      case 'wrong-password':
        return 'Incorrect Password. Please check your password and try again';
      case 'invalid-verification-code':
        return 'Invalid Verification code. Please enter a valid code';

      case 'invalid-verification-id':
        return 'Invalid Verification Id. Please request a new verification code';
      case 'quota-exceeded':
        return 'Quota Exceeded. Please try again later.';
      case 'email-already-exist':
        return 'The email address is already exist. Please use a different email';
      case 'provider-already-linked':
        return 'The account is already linked with another provider';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again';

      case 'credential-already-in-use':
        return 'This operation is sensitive and requires recent authentication. Please log in again';
    }
    return '';
  }
}
