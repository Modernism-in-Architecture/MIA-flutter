import 'dart:convert';


String convertToUTF8(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}