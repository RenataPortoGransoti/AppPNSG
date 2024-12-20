import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormularioDizimista extends StatelessWidget {
  final Function(String, String, String, String, String, String, String, String, String, String, String, String) onSubmit;
  final String baseUrl;

  FormularioDizimista({super.key, required this.onSubmit, required this.baseUrl});

  final _formKey = GlobalKey<FormState>();
  late String _nomeCompleto;
  late String _celular;
  late String _email;
  late String _nomeConjuge;
  late String _endereco;
  late String _numero;
  late String _apto;
  late String _bairro;
  late String _cep;
  late String _estadoCivil;
  late String _dataNascimento;
  late String _dataNascimentoConjuge;

  final List<String> estadoCivilOptions = ['Solteiro', 'Casado', 'Divorciado', 'Viúvo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    buildTextFormField(
                      'Nome completo*',
                          (value) => _nomeCompleto = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha o nome completo.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    buildTextFormField(
                      'Celular*',
                          (value) => _celular = value!,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha o celular.';
                        }
                        return null;
                      },
                      inputFormatters: [
                        MaskedInputFormatter('(##) #########'),
                      ],
                    ),
                    const SizedBox(height: 10),

                    buildTextFormField(
                      'Nome do cônjuge',
                          (value) => _nomeConjuge = value!,
                    ),
                    const SizedBox(height: 10),

                    buildTextFormField(
                      'Endereço*',
                          (value) => _endereco = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha o endereço.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: buildTextFormField(
                            'Nº*',
                                (value) => _numero = value!,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, preencha o número.';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: buildTextFormField(
                            'Complemento',
                                (value) => _apto = value!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    buildTextFormField(
                      'Bairro*',
                          (value) => _bairro = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha o bairro.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    buildTextFormField(
                      'CEP*',
                          (value) => _cep = value!,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha o CEP.';
                        }
                        return null;
                      },
                      inputFormatters: [
                        MaskedInputFormatter('#####-###'),
                      ],
                    ),
                    const SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Estado Civil*',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      items: estadoCivilOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        _estadoCivil = newValue!;
                      },
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: Colors.white,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione o estado civil.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    buildTextFormField(
                      'Data de Nascimento*',
                          (value) => _dataNascimento = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha a data de nascimento.';
                        }
                        return null;
                      },
                      inputFormatters: [
                        MaskedInputFormatter('##/##/####'),
                      ],
                    ),
                    const SizedBox(height: 10),

                    buildTextFormField(
                      'Data de Nascimento do Cônjuge',
                          (value) => _dataNascimentoConjuge = value!,
                      inputFormatters: [
                        MaskedInputFormatter('##/##/####'),
                      ],
                    ),
                    const SizedBox(height: 10),

                    buildTextFormField(
                      'E-mail*',
                          (value) => _email = value!,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha o e-mail.';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Por favor, insira um e-mail válido.';
                        }
                        return null;
                      },
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
                              _nomeConjuge,
                              _endereco,
                              _numero,
                              _apto,
                              _bairro,
                              _cep,
                              _estadoCivil,
                              _dataNascimento,
                              _dataNascimentoConjuge
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

  TextFormField buildTextFormField(String labelText, void Function(String?) onSaved, {TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator, List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        labelStyle: const TextStyle(color: Colors.black),
      ),
      style: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }
}

Future<String> fetchEmailFromApi(String baseUrl) async {
  final response = await http.get(Uri.parse('$baseUrl/contatosapi'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['email'];
  } else {
    throw Exception('Failed to load email');
  }
}