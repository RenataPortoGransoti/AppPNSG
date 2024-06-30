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
        return $horarios; // Retorna o array diretamente
    }

    public function indexApi()
    {
        $horarios = Horario::all()->groupBy('tipo');

        return response()->json($horarios);
    }


    public function store(Request $request)
    {
        Log::info('Request data:', $request->all());

        $this->storeHorarios($request, 'secretaria');
        $this->storeHorarios($request, 'missa');
        $this->storeHorarios($request, 'confissão');

        return redirect()->route('informacoes.index')->with('success', 'Horários salvos com sucesso!');
    }

    private function storeHorarios(Request $request, $tipo)
    {
        $horarios = $request->input("horarios_$tipo", []);
        $ids = $request->input("ids_$tipo", []);

        Log::info("Processing $tipo:", ['horarios' => $horarios, 'ids' => $ids]);

        foreach ($horarios as $index => $descricao) {
            if (!empty($descricao)) {
                $horarioId = $ids[$index];

                if ($horarioId) {
                    // Atualize o horário existente
                    $existingHorario = Horario::find($horarioId);
                    if ($existingHorario) {
                        $existingHorario->descricao = $descricao;
                        $existingHorario->save();
                    }
                } else {
                    // Crie um novo horário
                    Horario::create(['descricao' => $descricao, 'tipo' => $tipo]);
                }
            }
        }
    }

    public function destroy($id)
    {
        try {
            $horario = Horario::findOrFail($id);
            $horario->delete();

            return response()->json(['success' => true], 200);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }
}
