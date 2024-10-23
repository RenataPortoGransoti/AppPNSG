<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        // Validação dos campos
        $validation = Validator::make($request->all(), [
            'email'    => 'required|string|email',
            'password' => 'required|string',
        ]);

        if ($validation->fails()) {
            return response()->json([
                'message' => 'Erro ao validar dados',
                'success' => false,
            ]);
        }

        // Autenticação do usuário
        if (!Auth::attempt($request->only('email', 'password'))) {
            return response()->json([
                'message' => 'Usuário ou senha incorretos.',
                'success' => false,
            ]);
        }

        // Usuário autenticado com sucesso
        return response()->json([
            'message' => 'Login realizado com sucesso.',
            'success' => true,
            'user'    => Auth::user(), // Retorna as informações do usuário autenticado
        ]);
    }
}

