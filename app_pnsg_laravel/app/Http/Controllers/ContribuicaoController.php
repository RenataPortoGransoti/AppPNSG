<?php

namespace App\Http\Controllers;

use App\Http\Controllers\DizimoController;
use App\Http\Controllers\DoacaoController;
use Illuminate\Http\Request;

class ContribuicaoController extends Controller
{
    public function consultarContribuicao(DizimoController $dizimoController, DoacaoController $doacaoController)
    {
        $dizimo = $dizimoController->consultarDadosDizimo();
        $doacao = $doacaoController->consultarDadosDoacao();

        return view('contribua', [
            'dizimo' => $dizimo->original['dizimo'] ?? null,
            'doacao' => $doacao->original['doacao'] ?? null,
        ]);
    }
}
