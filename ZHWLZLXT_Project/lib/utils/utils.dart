import 'dart:ffi';
import 'dart:typed_data';



Uint8List toUnitList(String str) {
  int length = str.length;
  if (length % 2 != 0) {
    str = "0$str";
    length++;
  }
  List<int> s = str
      .toUpperCase()
      .codeUnits;
  Uint8List bArr = Uint8List(length >> 1);
  for (int i = 0; i < length; i += 2) {
    bArr[i >> 1] = ((hex(s[i]) << 4) | hex(s[i + 1]));
  }
  return bArr;
}


 hex(int c) {
  if (c >= '0'.codeUnitAt(0) && c <= '9'.codeUnitAt(0)) {
    return c - '0'.codeUnitAt(0);
  }
  if (c >= 'A'.codeUnitAt(0) && c <= 'F'.codeUnitAt(0)) {
    return (c - 'A'.codeUnitAt(0)) + 10;
  }
}