<?php

namespace App\Http\Controllers;

use App\Models\User;

class UserController extends Controller
{
    public function edit(User $user)
    {
        return view('profile.partials.editar-usuario', compact('user'));
    }
}
