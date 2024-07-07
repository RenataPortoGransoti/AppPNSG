<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PastoralController;
use App\Http\Controllers\EventoController;
use App\Http\Controllers\HorarioController;
use App\Http\Controllers\InformacoesController;
use App\Http\Controllers\ContatoController;
use App\Http\Controllers\AvisoController;
use App\Http\Controllers\EmailController;
use App\Models\Horario;

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
Route::delete('/eventos/{id}/excluir', [EventoController::class, 'deletarEvento'])->name('eventos.softDelete');


Route::put('/eventos/{id}/ativar', [EventoController::class, 'ativarEvento'])->name('eventos.ativar');

Route::get('/informacoes', [InformacoesController::class, 'index'])->name('informacoes.index');
Route::post('/horarios/store', [HorarioController::class, 'store'])->name('horarios.store');
Route::delete('/horarios/{id}', [HorarioController::class, 'destroy'])->name('horarios.destroy');
Route::post('/contatos/store', [ContatoController::class, 'store'])->name('contatos.store');
Route::delete('/contatos/{tipo}', [ContatoController::class, 'destroy'])->name('contatos.destroy');


Route::get('/inicio', [AvisoController::class, 'index'])->name('inicio.index');
Route::post('/avisos/store', [AvisoController::class, 'store'])->name('avisos.store');
Route::delete('/avisos/{id}', [AvisoController::class, 'destroy'])->name('avisos.destroy');



//Rota para informações das pastorais e eventos em JSON
Route::get('/pastoraisapi', [PastoralController::class, 'indexApi']);
Route::get('/eventosapi', [EventoController::class, 'indexApi']);
Route::get('/horariosapi', [HorarioController::class, 'indexApi']);
Route::get('/contatosapi', [ContatoController::class, 'indexApi']);
Route::get('/avisosapi', [AvisoController::class, 'indexApi']);

Route::post('/send-email', [EmailController::class, 'sendEmail']);
Route::get('/csrf-token', function () {
    return response()->json(['csrfToken' => csrf_token()]);
});
require __DIR__ . '/auth.php';
