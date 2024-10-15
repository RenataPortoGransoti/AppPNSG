<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules;

class ParoquianoController extends Controller
{
    public function registrarParoquiano(Request $request)
    {
        // Validação dos dados
        $validator = Validator::make($request->all(), [
            'nome' => 'required|string|max:255',
            'cpf' => 'required|string|size:14|unique:users|regex:/^\d{3}\.\d{3}\.\d{3}-\d{2}$/',
            'celular' => 'required|string|size:15|regex:/^\(\d{2}\) \d{5}-\d{4}$/',
            'email' => 'required|string|email|max:255|unique:users',
            'dataNascimento' => 'required|date_format:Y-m-d', // Formato Y-m-d vindo do Flutter
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Criação do usuário no banco de dados
        try {
            $user = User::create([
                'nome' => $request->input('nome'),
                'cpf' => $request->input('cpf'),
                'celular' => $request->input('celular'),
                'email' => $request->input('email'),
                'dataNascimento' => $request->input('dataNascimento'), // Formato Y-m-d
                'password' => Hash::make($request->input('password')),
                'tipo' => 'paroquiano(a)',
            ]);

            return response()->json(['message' => 'Usuário registrado com sucesso!', 'user' => $user], 201);
        } catch (\Illuminate\Database\QueryException $e) {
            return response()->json(['message' => 'Erro ao registrar usuário no banco de dados', 'error' => $e->getMessage()], 500);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Erro inesperado ao registrar usuário', 'error' => $e->getMessage()], 500);
        }
    }
}
