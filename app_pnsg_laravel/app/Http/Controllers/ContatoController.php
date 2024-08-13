<?php

namespace App\Http\Controllers;

use App\Models\Contato;
use App\Models\Horario;

use Illuminate\Http\Request;

class ContatoController extends Controller
{
    public function index()
    {
        $contatos = Contato::all()->groupBy('tipo');
        return $contatos;
    }

    public function carregarContatoApp()
    {
        $contatos = Contato::all()->groupBy('tipo');
        return response()->json($contatos);
    }

    public function cadastrarContato(Request $request)
    {
        $data = $request->only(['contato', 'email', 'instagram', 'facebook']);

        foreach ($data as $tipo => $valor) {
            $contato = Contato::firstOrNew(['tipo' => $tipo]);
            $contato->valor = $valor;
            $contato->save();
        }

        return redirect()->route('informacoes.index')->with('success', 'Contatos atualizados com sucesso!');
    }

    public function excluirContato($tipo)
    {
        $contato = Contato::where('tipo', $tipo)->first();
        if ($contato) {
            $contato->valor = null;
            $contato->save();
        }

        return response()->json(['success' => true]);
    }
}
