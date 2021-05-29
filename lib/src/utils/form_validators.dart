String baseValidator (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
}

String passwordValidator (value) {
  return value.length < 6 ? 'Password too short.' : null;
}