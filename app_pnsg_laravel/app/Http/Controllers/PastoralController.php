<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Pastoral;
use Illuminate\Support\Facades\Storage;

class PastoralController extends Controller
{
    public function consultarPastoral()
    {
        $pastorais = Pastoral::all();
        return view('pastorais', ['pastorais' => $pastorais]);
    }

    public function indexApi()
    {
        $pastorais = Pastoral::where('ativo', 1)->get();
        return response()->json($pastorais);
    }

    public function cadastrarPastoral(Request $request)
    {
        $maxFileSize = 20; // 20 MB

        $request->validate([
            'nomePastoral' => 'required|string|max:60',
            'descricao' => 'nullable|string',
            'photo' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        $nomePastoral = $request->input('nomePastoral');

        // Verificar se já existe uma pastoral com o mesmo nome (case-insensitive)
        $existingPastoral = Pastoral::whereRaw('LOWER(nome) = ?', [strtolower($nomePastoral)])->first();

        if ($existingPastoral) {
            if (!$existingPastoral->ativo) {
                // Ativar pastoral existente se estiver inativa
                $existingPastoral->ativo = 1;
                $existingPastoral->descricao = $request->input('descricao');

                if ($request->hasFile('photo')) {
                    $imagePath = $request->file('photo')->store('images', 'public');
                    $existingPastoral->imagem = $imagePath;
                }

                $existingPastoral->save();

                return redirect()->route('pastorais.index')->with('success', 'Pastoral reativada com sucesso.');
            } else {
                return redirect()->route('pastorais.index')->with('error', 'Uma pastoral com esse nome já existe.');
            }
        } else {
            // Criar uma nova pastoral
            $pastoral = new Pastoral;
            $pastoral->nome = $nomePastoral;
            $pastoral->descricao = $request->input('descricao');
            $pastoral->ativo = 1;

            if ($request->hasFile('photo')) {
                $imagePath = $request->file('photo')->store('images', 'public');
                $pastoral->imagem = $imagePath;
            }

            $pastoral->save();

            return redirect()->route('pastorais.index')->with('Sucesso', 'Pastoral criada com sucesso.');
        }
    }

    public function editarPastoral(Request $request, Pastoral $pastoral)
    {
        // Validação dos dados do formulário
        $request->validate([
            'nomePastoral' => 'required',
            'photo' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        // Para imagem
        if ($request->hasFile('photo')) {
            Storage::delete('public/' . $pastoral->imagem);

            // Faça o upload da nova imagem
            $image = $request->file('photo');
            $imageName = time() . '.' . $image->getClientOriginalExtension();
            $image->storeAs('public/images', $imageName);
            $pastoral->imagem = 'images/' . $imageName;
        }
        if ($request->has('delete_image')) {
            // Verifique se a imagem existe antes de excluir
            if ($pastoral->imagem) {
                // Atualize o campo de imagem para null
                $pastoral->imagem = null;
                $pastoral->save();
            }
        }
        // Atualizar os dados no banco de dados
        $pastoral->nome = $request->input('nomePastoral');
        $pastoral->descricao = $request->input('descricao');
        $pastoral->save();

        return redirect()->back()->with('success', 'Pastoral atualizada com sucesso!');
    }

    public function deleteImage(Request $request, Pastoral $pastoral)
    {
        // Verifique se a imagem existe antes de excluir
        if ($pastoral->imagem) {
            // Exclua a imagem do armazenamento
            Storage::delete('public/' . $pastoral->imagem);

            // Atualize o campo de imagem para null
            $pastoral->imagem = null;
            $pastoral->save();

            return redirect()->back()->with('success', 'Imagem excluída com sucesso.');
        } else {
            return redirect()->back()->with('error', 'Nenhuma imagem para excluir.');
        }
    }

    public function inativarPastoral(Request $request)
    {
        $id = $request->input('pastoral_id');
        $pastoral = Pastoral::find($id);

        if ($pastoral) {
            $pastoral->ativo = 0;
            $pastoral->save();
        }

        return redirect()->route('pastorais.index')->with('success', 'Pastoral inativada com sucesso.');
    }

    public function ativarPastoral($id)
    {
        $pastoral = Pastoral::find($id);

        if ($pastoral) {
            $pastoral->ativo = 1; // Definindo como ativo
            $pastoral->save();
        }

        return redirect()->route('pastorais.index')->with('success', 'Pastoral ativada com sucesso.');
    }
}
