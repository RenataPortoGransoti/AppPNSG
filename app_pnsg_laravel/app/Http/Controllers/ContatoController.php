<?php

namespace App\Http\Controllers;

use App\Models\Contato;
use App\Models\Horario;

use Illuminate\Http\Request;

class ContatoController extends Controller
{
    public function index()
    {
        $contatos = Contato::all();
        $contatosMap = $contatos->keyBy('tipo');
        $horarios = [
            'secretaria' => Horario::where('tipo', 'secretaria')->get(),
            'missa' => Horario::where('tipo', 'missa')->get(),
            'confissão' => Horario::where('tipo', 'confissão')->get(),
        ];

        return view('informacoes', compact('contatosMap', 'horarios'));
    }

    public function store(Request $request)
    {
        $data = $request->only(['contato', 'email', 'instagram', 'facebook']);

        foreach ($data as $tipo => $valor) {
            $contato = Contato::firstOrNew(['tipo' => $tipo]);
            $contato->valor = $valor;
            $contato->save();
        }

        return redirect()->route('contatos.index')->with('success', 'Contatos atualizados com sucesso!');
    }

    public function destroy($tipo)
    {
        $contato = Contato::where('tipo', $tipo)->first();
        if ($contato) {
            $contato->valor = null;
            $contato->save();
        }

        return response()->json(['success' => true]);
    }
}
