class AuthValidators {
  static String? validateEmail(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Email je povinný';
      }
      if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
        return 'Email není ve správném formátu';
      }
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Heslo je povinné';
      }
      if (value.length < 8) {
        return 'Heslo musí mít alespoň 8 znaků';
      }
      return null;
    }
  }

  static String? validateName(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Jméno je povinné';
      }
      return null;
    }
    return null;
  }

  static String? validateSurname(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Příjmení je povinné';
      }
      return null;
    }
    return null;
  }

  static String? validateNickname(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Přezdívka je povinná';
      }
      return null;
    }
    return null;
  }

  static String? validatePasswordConfirmation(String? value, String? password) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Heslo je povinné';
      }
      if (value.length < 8) {
        return 'Heslo musí mít alespoň 8 znaků';
      }
      if (value != password) {
        return 'Hesla se neshodují';
      }
      return null;
    }
    return null;
  }
}
