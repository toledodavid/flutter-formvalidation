import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProvider {

  final String _firebaseAPIKEY = 'AIzaSyAMFmXbM_WKYDoumNJ6xP0cPVseh2J8FXU';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final response = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseAPIKEY',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResponse = json.decode(response.body);

    print(decodedResponse);

    if (decodedResponse.containsKey('idToken')) {
      // Save token in Storage
      return {'ok': true, 'token': decodedResponse['idToken']};
    } else {
      return {'ok': false, 'message': decodedResponse['error']['message']};
    }

  }


  Future<Map<String, dynamic>> createUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final response = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseAPIKEY',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResponse = json.decode(response.body);
    
    print(decodedResponse);

    if (decodedResponse.containsKey('idToken')) {
      // Save token in Storage
      return {'ok': true, 'token': decodedResponse['idToken']};
    } else {
      return {'ok': false, 'message': decodedResponse['error']['message']};
    }
  }

}