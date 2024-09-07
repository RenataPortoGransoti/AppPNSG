<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Doacao;
use Illuminate\Support\Facades\Storage;

class DoacaoController extends Controller
{

    public function carregarDoacaoApp()
    {
        $doacao = Doacao::all();
        return response()->json($doacao);
    }

    public function consultarDadosDoacao()
    {
        $doacao = Doacao::first();

        return view('contribua', compact('doacao'));
    }


    public function salvarDadosDoacao(Request $request)
    {
        $request->validate([
            'chavePix' => 'required|string|max:255',
            'QRCode' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        $doacao = Doacao::first() ?? new Doacao;

        if ($request->has('removeQRCode') && $request->input('removeQRCode') == '1') {
            if ($doacao->QRCode) {
                Storage::delete('public/' . $doacao->QRCode);
                $doacao->QRCode = null;
            }
        } elseif ($request->hasFile('QRCode')) {
            if ($doacao->QRCode) {
                Storage::delete('public/' . $doacao->QRCode);
            }
            $imagePath = $request->file('QRCode')->store('images', 'public');
            $doacao->QRCode = $imagePath;
        }

        $doacao->chavePix = $request->input('chavePix');
        $doacao->save();

        return redirect()->route('doacao.consultar')->with('success', 'Dízimo salvo com sucesso.');
    }

    public function excluirDadosDoacao()
    {
        $doacao = Doacao::first();
        if ($doacao) {
            if ($doacao->QRCode) {
                Storage::delete('public/' . $doacao->QRCode);
            }

            $doacao->delete();
        }

        return redirect()->route('doacao.consultar');
    }
}
