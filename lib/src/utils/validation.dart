class Validation {
  static String? validatePass(String pass) {
    if (pass == '') {
      return 'Password invalid';
    }
    if (pass.length < 6) {
      return 'Password require minimum 6 characters';
    }
    return null;
  }

  static String? validateUser(String user) {
    if (user == '') {
      return 'Username invalid';
    }

    return null;
  }

  static String? validateRepassword(String pass, String repass) {
    if (validatePass(pass) == null) {
      if (repass == '') {
        return 'Please repeat your password';
      }
      if (repass != pass) {
        return 'Password and retype password do not match';
      }
      return null;
    }
    return validatePass(pass);
  }

  static String? validateEmail(String email) {
    if (email == '') {
      return 'Email is required';
    }
    var isValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
    if (!isValid) {
      return 'Email invalid';
    }
    return null;
  }
}
