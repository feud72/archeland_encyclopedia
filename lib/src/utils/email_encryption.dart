String encodeEmail(String email) {
  return email.replaceAll('@', '').replaceAll('.', '');
}
