import 'dart:convert';
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import 'package:sqflite/sqflite.dart';
import '../models/app_user.dart';
import '../utils/database_helper.dart';
class AuthController {
 final _algorithm = Pbkdf2(macAlgorithm: Hmac.sha256(), iterations: 100000, bits: 256);
 Future<List<int>> _hash(String password, List<int> salt) async {
  final key = await _algorithm.deriveKey(secretKey: SecretKey(utf8.encode(password)), nonce: salt);
  return key.extractBytes();
 }
 Future<void> register(String email, String password) async {
  final db = await DatabaseHelper.instance.database;
  final normalizedEmail = email.trim().toLowerCase();
  final salt = List<int>.generate(16, (_) => Random.secure().nextInt(256));
  final hash = await _hash(password, salt);
  try {
   await db.insert('users', {'email': normalizedEmail,
    'passwordHash': base64Encode(hash), 'salt': base64Encode(salt)});
  } on DatabaseException catch (e) {
   if (e.isUniqueConstraintError()) throw const AuthException('Email đã được đăng ký');
   rethrow;
  }
 }
 Future<AppUser?> login(String email, String password) async {
  final db = await DatabaseHelper.instance.database;
  final rows = await db.query('users', where: 'email = ?',
      whereArgs: [email.trim().toLowerCase()], limit: 1);
  if (rows.isEmpty) return null;
  final row = rows.first;
  final actual = await _hash(password, base64Decode(row['salt'] as String));
  final expected = base64Decode(row['passwordHash'] as String);
  if (actual.length != expected.length) return null;
  var difference = 0;
  for (var i = 0; i < actual.length; i++) { difference |= actual[i] ^ expected[i]; }
  return difference == 0 ? AppUser.fromMap(row) : null;
 }
}
class AuthException implements Exception {
 final String message;
 const AuthException(this.message);
}
