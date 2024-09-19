<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
use Illuminate\View\View;
use Illuminate\Support\Facades\Validator;

class RegisteredUserController extends Controller
{

    public function create(): View
    {
        return view('auth.register');
    }

    /**
     * Handle an incoming registration request.
     *
     * @throws \Illuminate\Validation\ValidationException
     */


    public function cadastrarSecretario(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nome' => ['required', 'string', 'max:255'],
            'cpf' => ['required', 'string', 'max:14', 'unique:users,cpf'],
            'celular' => ['required', 'string', 'max:15'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users,email'],
            'dataNascimento' => ['required', 'date_format:d/m/Y'], // Ajuste para o formato correto
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);

        if ($validator->fails()) {
            return redirect()->back()
                ->withErrors($validator)
                ->withInput();
        }

        $dataNascimento = \Carbon\Carbon::createFromFormat('d/m/Y', $request->input('dataNascimento'))->format('Y-m-d');

        $user = User::create([
            'nome' => $request->input('nome'),
            'cpf' => $request->input('cpf'),
            'celular' => $request->input('celular'),
            'email' => $request->input('email'),
            'dataNascimento' => $dataNascimento,
            'password' => Hash::make($request->input('password')),
            'tipo' => 'secretário(a)',
        ]);

        event(new Registered($user));

        Auth::login($user);

        return redirect()->route('dashboard');
    }

    public function registrarParoquiano(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nome' => 'required|string|max:255',
            'cpf' => 'required|string|max:14',
            'celular' => ['required', 'string', 'max:15'],
            'email' => 'required|string|email|max:255|unique:users',
            'dataNascimento' => 'required|date_format:Y-m-d',
            'password' => ['required', Rules\Password::defaults()],
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $user = User::create([
            'nome' => $request->input('nome'),
            'cpf' => $request->input('cpf'),
            'celular' => $request->input('celular'),
            'email' => $request->input('email'),
            'dataNascimento' => $request->input('dataNascimento'),
            'password' => Hash::make($request->input('password')),
            'tipo' => 'paroquiano(a)',
        ]);

        return response()->json(['message' => 'Usuário registrado com sucesso!'], 201);
    }
}
