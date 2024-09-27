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
  final _cpfController = MaskedTextController(mask: '000.000.000-00');
  final _celularController = MaskedTextController(mask: '(00) 00000-0000');
  final _dataNascimentoController = MaskedTextController(mask: '00/00/0000');
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
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
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Adicionar informações adicionais no Firestore
      await FirebaseFirestore.instance.collection('users').doc(
          userCredential.user!.uid).set({
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
      final dataNascimentoFormatted = DateFormat('yyyy-MM-dd').format(
          parsedDate);

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
        _errorMessage =
        'Erro ao criar a conta. Verifique os detalhes e tente novamente.';
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
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/brasao_pnsg.jpg',
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Crie sua conta',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF036896),
              ),
            ),
            SizedBox(height: 14),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            _buildLabelInputField(
                'Nome completo*', _nameController, TextInputType.text),
            _buildLabelInputField(
                'E-mail*', _emailController, TextInputType.emailAddress),
            _buildLabelInputField('CPF*', _cpfController, TextInputType.number,
                hintText: '000.000.000-00'),
            _buildLabelInputField(
                'Celular*', _celularController, TextInputType.phone,
                hintText: '(00) 00000-0000'),
            _buildLabelInputField(
                'Data de Nascimento*', _dataNascimentoController,
                TextInputType.datetime, hintText: 'dd/mm/aaaa'),
            _buildPasswordField('Senha*', _passwordController),
            _buildPasswordField('Confirmar Senha*', _confirmPasswordController),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.blue[200],
                foregroundColor: Colors.white,
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

  Widget _buildLabelInputField(String label, TextEditingController controller,
      TextInputType keyboardType, {String? hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlue),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 8.0,
                  horizontal: 12.0), // Reduzindo o padding interno
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          TextField(
            controller: controller,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xFF8DBCE7),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlue),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0,
                  horizontal: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}