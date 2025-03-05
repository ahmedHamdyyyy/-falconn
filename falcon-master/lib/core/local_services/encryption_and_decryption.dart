// import 'package:encrypt/encrypt.dart' as encrypt;
// import 'package:encrypt/encrypt.dart';
// import 'package:flutter/material.dart';
//
// class EncryptionHelper {
//   // Generate a key with a length of 32 bytes (256 bits)
//   final encrypt.Key _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1'); // Must be exactly 32 characters
//
//   // IV (Initialization Vector) should be 16 bytes long
//   final IV _iv = IV.fromLength(16);
//
//   // Encryption function
//   String encryptText(String plainText) {
//     final encrypter = Encrypter(AES(_key)); // Using AES encryption
//     final encrypted = encrypter.encrypt(plainText, iv: _iv);
//     return encrypted.base64; // Return the base64 encoded string
//   }
//
//   // Decryption function
//   String decryptText(String encryptedText) {
//     final encrypter = Encrypter(AES(_key));
//     final decrypted = encrypter.decrypt(Encrypted.fromBase64(encryptedText), iv: _iv);
//     return decrypted; // Return the decrypted plain text
//   }
// }
