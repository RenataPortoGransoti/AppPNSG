<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    /**
     * Display the dashboard with users list and filtering options.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\View\View
     */
    public function index(Request $request)
    {
        // Cria a query inicial
        $query = User::query();

        // Aplica filtros se o parâmetro 'tipo' estiver presente
        if ($request->filled('tipo')) {
            $query->where('tipo', $request->input('tipo'));
        }

        // Obtém todos os usuários que correspondem à query
        $users = $query->get();

        // Retorna a view com os usuários
        return view('dashboard', compact('users'));
    }
}
