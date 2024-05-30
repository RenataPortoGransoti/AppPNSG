<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HorariosController;
use App\Http\Controllers\Controller;
use App\Http\Controllers\PastoralController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});


Route::get('/inicio', function () {
    return view('inicio');
});

Route::get('/pastorais', function () {
    return view('pastorais');
});
Route::get('/eventos', function () {
    return view('eventos');
});
Route::get('/contribua', function () {
    return view('contribua');
});
Route::get('/informacoes', function () {
    return view('informacoes');
});


Route::get('/pastorais', [PastoralController::class, 'index'])->name('pastorais.index');
Route::post('/pastorais', [PastoralController::class, 'store'])->name('pastorais.store');
Route::put('/pastorais/{pastoral}', [PastoralController::class, 'update'])->name('pastorais.update');
Route::post('/pastorais/inativar', [PastoralController::class, 'inativar'])->name('pastorais.inativar');
Route::post('/pastorais/{pastoral}/delete-image', [PastoralController::class, 'deleteImage'])->name('pastorais.deleteImage');
Route::put('/pastorais/ativar/{id}', [PastoralController::class, 'ativar'])->name('pastorais.ativar');


require __DIR__ . '/auth.php';


//Rota para informações das pastorais em JSON
Route::get('/pastoraisapi', [PastoralController::class, 'indexApi']);
