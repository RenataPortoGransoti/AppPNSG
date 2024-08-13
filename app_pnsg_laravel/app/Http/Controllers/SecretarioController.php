<?php

namespace App\Http\Controllers;

use App\Models\Secretario;
use Illuminate\Http\Request;

class SecretarioController extends Controller
{
    public function store(Request $request)
    {
        $data = $request->only('id_usuario', 'codSecretario');
        $secretario = Secretario::create($data);

        return response()->json(['secretario' => $secretario], 201);
    }

    public function show($id)
    {
        $secretario = Secretario::find($id);

        if (!$secretario) {
            return response()->json(['error' => 'Not Found'], 404);
        }

        return response()->json(['secretario' => $secretario]);
    }
}
