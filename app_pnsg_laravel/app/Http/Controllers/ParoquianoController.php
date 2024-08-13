<?php

namespace App\Http\Controllers;

use App\Models\Paroquiano;
use Illuminate\Http\Request;

class ParoquianoController extends Controller
{
    public function store(Request $request)
    {
        $data = $request->only(
            'id_usuario',
            'pastoral_id',
            'ruaEndereco',
            'bairroEndereco',
            'numeroEndereco',
            'estadoCivil',
            'dataCasamento',
            'dizimista',
            'numeroDizimista'
        );

        $paroquiano = Paroquiano::create($data);

        return response()->json(['paroquiano' => $paroquiano], 201);
    }

    public function show($id)
    {
        $paroquiano = Paroquiano::find($id);

        if (!$paroquiano) {
            return response()->json(['error' => 'Not Found'], 404);
        }

        return response()->json(['paroquiano' => $paroquiano]);
    }
}
