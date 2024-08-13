<?php

namespace App\Http\Controllers;

use App\Models\Usuario;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class UsuarioController extends Controller
{
    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            return response()->json(['user' => $user]);
        }

        return response()->json(['error' => 'Unauthorized'], 401);
    }

    public function register(Request $request)
    {
        $data = $request->only('nome', 'cpf', 'celular', 'email', 'dataNascimento', 'tipo', 'password');
        $data['password'] = Hash::make($data['password']);

        $usuario = Usuario::create($data);

        return response()->json(['user' => $usuario], 201);
    }
}
