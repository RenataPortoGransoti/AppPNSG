<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Dizimo;
use Illuminate\Support\Facades\Storage;

class DizimoController extends Controller
{
    public function consultarDadosDizimo()
    {
        $dizimo = Dizimo::first();

        return view('contribua', compact('dizimo'));
    }


    public function salvarDadosDizimo(Request $request)
    {
        $request->validate([
            'chavePix' => 'required|string|max:255',
            'QRCode' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        $dizimo = Dizimo::first() ?? new Dizimo;

        if ($request->has('removeQRCode') && $request->input('removeQRCode') == '1') {
            if ($dizimo->QRCode) {
                Storage::delete('public/' . $dizimo->QRCode);
                $dizimo->QRCode = null; // Remover a referência da imagem no banco de dados
            }
        } elseif ($request->hasFile('QRCode')) {
            if ($dizimo->QRCode) {
                Storage::delete('public/' . $dizimo->QRCode);
            }
            $imagePath = $request->file('QRCode')->store('images', 'public');
            $dizimo->QRCode = $imagePath;
        }

        $dizimo->chavePix = $request->input('chavePix');
        $dizimo->save();

        return redirect()->route('dizimo.consultar')->with('success', 'Dízimo salvo com sucesso.');
    }

    public function excluirDadosDizimo()
    {
        $dizimo = Dizimo::first();
        if ($dizimo) {
            if ($dizimo->QRCode) {
                Storage::delete('public/' . $dizimo->QRCode);
            }

            $dizimo->delete();
        }

        return redirect()->route('dizimo.consultar');
    }
}
