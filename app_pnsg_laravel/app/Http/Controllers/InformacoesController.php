<?php

namespace App\Http\Controllers;

use App\Http\Controllers\HorarioController;
use App\Http\Controllers\ContatoController;
use Illuminate\Http\Request;

class InformacoesController extends Controller
{
    public function index(HorarioController $horarioController, ContatoController $contatoController)
    {
        $horarios = $horarioController->index();
        $contatosMap = $contatoController->index();

        return view('informacoes', compact('horarios', 'contatosMap'));
    }
}
