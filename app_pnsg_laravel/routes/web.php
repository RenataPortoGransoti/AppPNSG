<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PastoralController;
use App\Http\Controllers\EventoController;
use App\Http\Controllers\HorarioController;
use App\Http\Controllers\ContatoController;


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

Route::get('/pastorais', [PastoralController::class, 'consultarPastoral'])->name('pastorais.index');
Route::post('/pastorais', [PastoralController::class, 'cadastrarPastoral'])->name('pastorais.store');
Route::put('/pastorais/{pastoral}', [PastoralController::class, 'editarPastoral'])->name('pastorais.update');
Route::post('/pastorais/inativar', [PastoralController::class, 'inativarPastoral'])->name('pastorais.inativar');
Route::post('/pastorais/{pastoral}/delete-image', [PastoralController::class, 'deleteImage'])->name('pastorais.deleteImage');
Route::put('/pastorais/ativar/{id}', [PastoralController::class, 'ativarPastoral'])->name('pastorais.ativar');

// Route::get('/eventos', [EventoController::class, 'indexEvento'])->name('eventos.index');
Route::get('/eventos', [EventoController::class, 'consultarEvento'])->name('eventos.index');;
Route::post('/eventos', [EventoController::class, 'cadastrarEvento'])->name('eventos.store');
Route::put('/eventos/{evento}', [EventoController::class, 'editarEvento'])->name('eventos.editarEvento');
Route::post('/eventos/inativar', [EventoController::class, 'inativarEvento'])->name('eventos.inativar');
// Route::delete('/eventos/{id}', [EventoController::class, 'deletarEvento'])->name('eventos.delete');
Route::delete('/eventos/{id}/soft-delete', [EventoController::class, 'deletarEvento'])->name('eventos.softDelete');


Route::put('/eventos/{id}/ativar', [EventoController::class, 'ativarEvento'])->name('eventos.ativar');

// web.php
Route::get('/informacoes', [HorarioController::class, 'index'])->name('informacoes.index');
Route::post('/horarios/store', [HorarioController::class, 'store'])->name('horarios.store');
Route::delete('/horarios/{id}', [HorarioController::class, 'destroy'])->name('horarios.destroy');
Route::resource('contatos', ContatoController::class)->only(['index', 'store', 'destroy']);





require __DIR__ . '/auth.php';

//Rota para informações das pastorais em JSON
Route::get('/pastoraisapi', [PastoralController::class, 'indexApi']);
