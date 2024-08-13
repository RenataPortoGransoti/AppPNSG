<?php

namespace App\Http\Controllers;

use App\Models\Aviso;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class AvisoController extends Controller
{
    public function consultarAvisos()
    {
        $avisos = Aviso::all();
        return view('inicio', ['avisos' => $avisos]);
    }

    public function carregarAvisosApp()
    {
        $avisos = Aviso::all();
        return response()->json($avisos);
    }

    public function cadastrarAviso(Request $request)
    {
        Log::info('Request data:', $request->all());

        $avisos = $request->input('avisos', []);
        $ids = $request->input('ids', []);

        Log::info('Processing avisos:', ['avisos' => $avisos, 'ids' => $ids]);

        foreach ($avisos as $index => $descricao) {
            if (!empty($descricao)) {
                $avisoId = $ids[$index] ?? null;

                if ($avisoId) {
                    // Atualize o aviso existente somente se mudou
                    $existingAviso = Aviso::find($avisoId);
                    if ($existingAviso && $existingAviso->aviso != $descricao) {
                        $existingAviso->aviso = $descricao;
                        $existingAviso->save();
                    }
                } else {
                    // Crie um novo aviso
                    Aviso::create(['aviso' => $descricao]);
                }
            }
        }

        return redirect()->route('inicio.index')->with('success', 'Avisos salvos com sucesso!');
    }

    public function excluirAviso($id)
    {
        $aviso = Aviso::find($id);
        if ($aviso) {
            $aviso->delete();
            return redirect()->route('inicio.index')
                ->with('success', 'Aviso excluído com sucesso.');
        } else {
            return response()->json(['error' => 'Aviso não encontrado'], 404);
        }
    }
}
