<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HorariosController extends Controller
{
    public function index()
    {
        $horarios = [
            [
                'titulo' => 'Horários Secretaria Paroquial',
                'visivel' => true, // Definir se os horários estão visíveis ou não
                'texto' => [
                    'Segunda à Sexta: 8h às 12h e 14h às 18h',
                    'Sábado: 14h às 18h'
                ]
            ],
            [
                'titulo' => 'Horários Missa',
                'visivel' => true,
                'texto' => [
                    'Sábado: 7h e 19h',
                    'Domingo: 8h, 10h e 19h',
                    'Segunda à Sexta: 18:30h'
                ]
            ],
            [
                'titulo' => 'Horários Confissões',
                'visivel' => true,
                'texto' => [
                    'Terça e Quinta: 17:30h às 18:20h'
                ]
            ]
        ];

        return view('informacoes', ['horarios' => $horarios]);

    }

}
