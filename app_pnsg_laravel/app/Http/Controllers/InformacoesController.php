<?php

namespace App\Http\Controllers;



class InformacoesController extends Controller

{
    public function index()
    {
        // Carregar os horários (substitua isso pela lógica real para carregar os horários)
        $horarios = Horario::all();

        // Retornar a visão 'informacoes' com os horários
        return view('informacoes.index', ['horarios' => $horarios]);
    }
}
