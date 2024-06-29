<?php

namespace App\Http\Controllers;

use App\Models\Aviso;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class AvisoController extends Controller
{
    public function index()
    {
        $avisos = Aviso::all();
        return view('inicio', compact('avisos'));
    }

    public function store(Request $request)
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

    public function destroy($id)
    {
        try {
            $aviso = Aviso::findOrFail($id);
            $aviso->delete();

            return response()->json(['success' => true], 200);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }
}
