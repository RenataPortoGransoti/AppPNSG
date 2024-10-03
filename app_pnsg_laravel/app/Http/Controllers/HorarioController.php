<?php

namespace App\Http\Controllers;

use App\Models\Horario;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class HorarioController extends Controller
{
    public function index()
    {
        $horarios = [
            'secretaria' => Horario::where('tipo', 'secretaria')->get(),
            'missa' => Horario::where('tipo', 'missa')->get(),
            'confissão' => Horario::where('tipo', 'confissão')->get(),
        ];
        return $horarios;
    }

    public function carregarHorariosApp()
    {
        $horarios = Horario::all()->groupBy('tipo');
        return response()->json($horarios);
    }

    public function cadastrarHorario(Request $request)
    {
        Log::info('Request data:', $request->all());

        $storeHorarios = function ($tipo) use ($request) {
            $horarios = $request->input("horarios_{$tipo}", []);
            $ids = $request->input("ids_{$tipo}", []);

            Log::info("Processando horários do tipo {$tipo}", ['horarios' => $horarios, 'ids' => $ids]);

            foreach ($horarios as $index => $descricao) {
                if (!empty($descricao)) {
                    $horarioId = $ids[$index] ?? null;

                    if ($horarioId) {
                        $existingHorario = Horario::find($horarioId);
                        if ($existingHorario) {
                            $existingHorario->descricao = $descricao;
                            $existingHorario->save();
                        }
                    } else {
                        Horario::create([
                            'descricao' => $descricao,
                            'tipo' => $tipo
                        ]);
                    }
                }
            }
        };

        $storeHorarios('secretaria');
        $storeHorarios('missa');
        $storeHorarios('confissão');

        return redirect()->route('informacoes.index')->with('success', 'Horários salvos com sucesso!');
    }

    public function excluirHorario($id)
    {
        try {
            $horario = Horario::findOrFail($id);
            $horario->delete();
            return redirect()->route('informacoes.index')
                ->with('success', 'Horário excluído com sucesso.');
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }
}
