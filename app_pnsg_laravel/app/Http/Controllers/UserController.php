<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function edit(User $user)
    {
        return view('profile.partials.editar-usuario', compact('user'));
    }

    public function editarSecretario(Request $request, User $user)
    {
        $validator = Validator::make($request->all(), [
            'nome' => ['required', 'string', 'max:255'],
            'cpf' => ['required', 'string', 'max:14', 'unique:users,cpf,' . $user->id],
            'celular' => ['required', 'string', 'max:15'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users,email,' . $user->id],
            'dataNascimento' => ['required', 'date_format:d/m/Y'],
            'tipo' => ['required', 'string'],
        ]);

        if ($validator->fails()) {
            return redirect()->back()
                ->withErrors($validator)
                ->withInput();
        }

        $dataNascimento = \Carbon\Carbon::createFromFormat('d/m/Y', $request->input('dataNascimento'))->format('Y-m-d');

        $user->update([
            'nome' => $request->input('nome'),
            'cpf' => $request->input('cpf'),
            'celular' => $request->input('celular'),
            'email' => $request->input('email'),
            'dataNascimento' => $dataNascimento,
            'tipo' => $request->input('tipo'),
        ]);

        return redirect()->route('dashboard')->with('status', 'Secretário(a) atualizado(a) com sucesso!');
    }

    public function inativarSecretario(Request $request)
    {
        $id = $request->input('user_id');
        $user = User::find($id);

        if ($user) {
            $user->ativo = 0;
            $user->save();
        }

        return redirect()->back()->with('status', 'Secretário(a) inativado(a) com sucesso!');
    }

    public function ativarSecretario($id)
    {
        $user = User::find($id);

        if ($user) {
            $user->ativo = 1;
            $user->save();
        }

        return redirect()->back()->with('status', 'Secretário(a) ativado(a) com sucesso!');
    }
}
