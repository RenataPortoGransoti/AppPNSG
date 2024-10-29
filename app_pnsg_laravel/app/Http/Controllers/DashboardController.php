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

        $query = User::query();

        if ($request->filled('tipo')) {
            $query->where('tipo', $request->input('tipo'));
        }

        $users = $query->get();

        return view('dashboard', compact('users'));
    }
}
