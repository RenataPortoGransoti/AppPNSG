<?php

namespace App\Http\Controllers;

use App\Http\Controllers\HorarioController;
use App\Http\Controllers\ContatoController;
use Illuminate\Http\Request;

class ContribuicaoController extends Controller
{
    public function consultarContribuicao(DizimoController $dizimoController, DoacaoController $doacaoController)
    {
        $dizimo = $dizimoController->consultarDadosDizimo();
        $doacao = $doacaoController->consultarDadosDoacao();

        return view('contribua', compact('dizimo', 'doacao'));
    }
}
