<?php

namespace App\Http\Controllers;

use App\Models\Dizimo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class DizimoController extends Controller
{
    public function consultarDadosDizimo()
    {
        $dizimo = Dizimo::first();
        return view('contribua', compact('dizimo'));
    }

    public function salvarDadosDizimo(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'chavePix' => 'required|string|max:255',
            'QRCode' => 'nullable|string|max:255'
        ]);

        if ($validator->fails()) {
            return redirect()->back()
                ->withErrors($validator)
                ->withInput();
        }

        $dizimo = Dizimo::first();
        if (!$dizimo) {
            $dizimo = new Dizimo();
        }
        $dizimo->chavePix = $request->chavePix;
        $dizimo->QRCode = $request->QRCode;
        $dizimo->save();

        return redirect()->route('dizimo.consultar');
    }

    public function excluirDadosDizimo()
    {
        $dizimo = Dizimo::first();
        if ($dizimo) {
            $dizimo->delete();
        }
        return redirect()->route('dizimo.consultar');
    }
}
