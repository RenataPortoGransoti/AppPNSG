import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../config.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpfController = TextEditingController();
  final _celularController = TextEditingController();
  final _dataNascimentoController = MaskedTextController(mask: '00/00/0000');
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  void _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_nameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _cpfController.text.isEmpty ||
          _celularController.text.isEmpty ||
          _dataNascimentoController.text.isEmpty) {
        setState(() {
          _errorMessage = 'Por favor, preencha todos os campos.';
        });
        return;
      }

      if (!_emailController.text.contains('@')) {
        setState(() {
          _errorMessage = 'Por favor, insira um e-mail válido.';
        });
        return;
      }

      // Criação do usuário no Firebase
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Adicionar informações adicionais no Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'cpf': _cpfController.text,
        'celular': _celularController.text,
        'dataNascimento': _dataNascimentoController.text,
        'type': 'paroquiano',
      });

      // Converter dataNascimento para o formato Y-m-d
      final dateFormat = DateFormat('dd/MM/yyyy');
      final parsedDate = dateFormat.parse(_dataNascimentoController.text);
      final dataNascimentoFormatted = DateFormat('yyyy-MM-dd').format(parsedDate);

      // Enviar dados para a API Laravel
      final response = await http.post(
        Uri.parse('${Config.baseUrl}register-paroquiano'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'nome': _nameController.text,
          'email': _emailController.text,
          'cpf': _cpfController.text,
          'celular': _celularController.text,
          'dataNascimento': dataNascimentoFormatted,
          'password': _passwordController.text,
          'password_confirmation': _confirmPasswordController.text,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.of(context).pop();
      } else {
        final responseData = jsonDecode(response.body);
        setState(() {
          _errorMessage = 'Erro: ${responseData['errors']}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao criar a conta. Verifique os detalhes e tente novamente.';
      });
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Registrar', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF036896),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/brasao_pnsg.jpg',
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Crie sua conta',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF036896),
              ),
            ),
            SizedBox(height: 20),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            _buildTextField('Nome', _nameController, TextInputType.text),
            _buildTextField('Email', _emailController, TextInputType.emailAddress),
            _buildTextField('Senha', _passwordController, TextInputType.visiblePassword, obscureText: true),
            _buildTextField('Confirmar Senha', _confirmPasswordController, TextInputType.visiblePassword, obscureText: true),
            _buildTextField('CPF', _cpfController, TextInputType.number),
            _buildTextField('Celular', _celularController, TextInputType.phone),
            _buildTextField('Data de Nascimento (dd/mm/aaaa)', _dataNascimentoController, TextInputType.datetime),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.blue[200],
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 66, vertical: 12),
              ),
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Registrar', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType keyboardType, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
