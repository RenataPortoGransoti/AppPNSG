<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Evento;
use Illuminate\Support\Facades\Validator;

class EventoController extends Controller
{
    public function consultarEvento()
    {
        $eventos = Evento::all();
        return view('eventos', ['eventos' => $eventos]);
    }

    public function carregarEventosAtivosApp()
    {
        $eventos = Evento::where('ativo', 1)->get();
        return response()->json($eventos);
    }

    public function cadastrarEvento(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nome_evento' => 'required|string|max:50',
            'data_inicio' => 'required|date',
            'data_fim' => 'nullable|date|after_or_equal:data_inicio',
            'local' => 'required|string|max:100',
            'descricao' => 'nullable|string|max:255',
            'ativo' => 'boolean'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $nomeEvento = $request->input('nome_evento');

        $existingEvento = Evento::whereRaw('LOWER(nome_evento) = ?', [strtolower($nomeEvento)])->first();

        if ($existingEvento) {
            if (!$existingEvento->ativo) {
                $existingEvento->ativo = 1;
                $existingEvento->data_inicio = $request->input('data_inicio');
                $existingEvento->data_fim = $request->input('data_fim');
                $existingEvento->local = $request->input('local');
                $existingEvento->descricao = $request->input('descricao');
                $existingEvento->secretario_id = auth()->id();

                $existingEvento->save();

                return response()->json(['success' => 'Evento reativado com sucesso.'], 200);
            } else {
                return response()->json(['error' => 'Um evento com esse nome já existe.'], 400);
            }
        } else {
            Evento::create(array_merge($request->all(), [
                'ativo' => 1,
                'secretario_id' => auth()->id()
            ]));
            return  redirect()->route('eventos.index')->with('success', 'Evento cadastrado com sucesso.');
        }
    }

    public function editarEvento(Request $request, Evento $evento)
    {
        $validator = Validator::make($request->all(), [
            'edit_nome_evento' => 'required|string|max:50',
            'edit_data_inicio' => 'required|date',
            'edit_data_fim' => 'nullable|date|after_or_equal:edit_data_inicio',
            'edit_local' => 'required|string|max:100',
            'edit_descricao' => 'nullable|string|max:255',
        ], [
            'edit_data_fim.after_or_equal' => 'A data de fim deve ser uma data posterior ou igual à data de início.',
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $evento->update([
            'nome_evento' => $request->edit_nome_evento,
            'data_inicio' => $request->edit_data_inicio,
            'hora_inicio' => $request->edit_hora_inicio,
            'data_fim' => $request->edit_data_fim,
            'hora_fim' => $request->edit_hora_fim,
            'local' => $request->edit_local,
            'descricao' => $request->edit_descricao,
        ]);
        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        }

        return redirect()->route('eventos.index')->with('success', 'Evento editado com sucesso.');
    }

    public function excluirEvento($id)
    {
        $evento = Evento::find($id);
        if ($evento) {
            $evento->delete();
            return redirect()->route('eventos.index')
                ->with('success', 'Evento excluído com sucesso.');
        } else {
            return redirect()->route('eventos.index')
                ->with('error', 'Evento não encontrado.');
        }
    }

    public function inativarEvento(Request $request)
    {
        $id = $request->input('evento_id');
        $evento = Evento::find($id);

        if ($evento) {
            $evento->ativo = 0;
            $evento->save();
        }

        return redirect()->route('eventos.index')->with('success', 'Evento inativado com sucesso.');
    }

    public function ativarEvento($id)
    {
        $evento = Evento::find($id);

        if ($evento) {
            $evento->ativo = 1;
            $evento->save();
        }
        return redirect()->route('eventos.index')->with('success', 'Evento ativado com sucesso.');
    }
}
