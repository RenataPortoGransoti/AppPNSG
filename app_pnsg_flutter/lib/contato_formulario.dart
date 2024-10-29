import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'logger.dart';

class ContactForm extends StatelessWidget {
  final Function(String, String, String, String) onSubmit;
  final String baseUrl;

  ContactForm({super.key, required this.onSubmit, required this.baseUrl});

  final _formKey = GlobalKey<FormState>();
  late String _nomeCompleto;
  late String _email;
  late String _celular;
  late String _mensagem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nome Completo*',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu nome completo';
                        }
                        return null;
                      },
                      onSaved: (value) => _nomeCompleto = value!,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'E-mail para contato*',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um e-mail válido';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Celular para contato*',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        MaskedInputFormatter('(##) #########'),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um número de celular';
                        }
                        return null;
                      },
                      onSaved: (value) => _celular = value!,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Mensagem*',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma mensagem';
                        }
                        return null;
                      },
                      onSaved: (value) => _mensagem = value!,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          onSubmit(
                            _nomeCompleto,
                            _email,
                            _celular,
                            _mensagem,
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue[200],
                        foregroundColor: Colors.black,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Enviar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> fetchCSRFToken(String baseUrl) async {
    try {
      final Uri uri =
          Uri.parse('$baseUrl/csrf-token');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String csrfToken = responseData[
            'csrfToken'];
        return csrfToken;
      } else {
        if (kDebugMode) {
          print('Erro ao obter token CSRF: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao obter token CSRF: $e');
      }
      return null;
    }
  }

  Future<void> enviarRequisicaoComToken(
    String baseUrl,
    String nomeCompleto,
    String email,
    String celular,
    String mensagem,
  ) async {
    try {
      String? csrfToken = await fetchCSRFToken(baseUrl);

      if (csrfToken != null) {
        final Uri uri = Uri.parse('$baseUrl/send-email');

        final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': csrfToken,
          },
          body: jsonEncode({
            'nomeCompleto': nomeCompleto,
            'email': email,
            'celular': celular,
            'mensagem': mensagem,
          }),
        );

        if (response.statusCode == 200) {
          logger.i('Email enviado com sucesso');
        } else {
          if (kDebugMode) {
            print('Falha ao enviar email: ${response.body}');
          }
        }
      } else {
        if (kDebugMode) {
          print('Não foi possível obter o token CSRF');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao enviar email: $e');
      }
    }
  }
}
