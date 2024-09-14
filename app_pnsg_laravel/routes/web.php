<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PastoralController;
use App\Http\Controllers\EventoController;
use App\Http\Controllers\HorarioController;
use App\Http\Controllers\InformacoesController;
use App\Http\Controllers\ContatoController;
use App\Http\Controllers\AvisoController;
use App\Http\Controllers\ContribuicaoController;
use App\Http\Controllers\DizimoController;
use App\Http\Controllers\DoacaoController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\UserController;

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

Route::get('/inicio', [AvisoController::class, 'consultarAvisos'])->name('inicio.index');
Route::post('/avisos/store', [AvisoController::class, 'cadastrarAviso'])->name('avisos.store');
Route::delete('/avisos/{aviso}', [AvisoController::class, 'excluirAviso'])->name('avisos.destroy');

Route::get('/contribua', [ContribuicaoController::class, 'consultarContribuicao'])->name('contribuicao.index');
Route::delete('/dizimo/excluir', [DizimoController::class, 'excluirDadosDizimo'])->name('dizimo.excluir');
Route::delete('/doacao/excluir', [DoacaoController::class, 'excluirDadosDoacao'])->name('doacao.excluir');

Route::get('/dizimo', [DizimoController::class, 'consultarDadosDizimo'])->name('dizimo.consultar');
Route::post('/dizimo/salvar', [DizimoController::class, 'salvarDadosDizimo'])->name('dizimo.salvar');

Route::get('/doacao', [DoacaoController::class, 'consultarDadosDoacao'])->name('doacao.consultar');
Route::post('/doacao/salvar', [DoacaoController::class, 'salvarDadosDoacao'])->name('doacao.salvar');


Route::get('/pastorais', [PastoralController::class, 'consultarPastoral'])->name('pastorais.index');
Route::post('/pastorais', [PastoralController::class, 'cadastrarPastoral'])->name('pastorais.store');
Route::put('/pastorais/{pastoral}', [PastoralController::class, 'editarPastoral'])->name('pastorais.update');
Route::post('/pastorais/inativar', [PastoralController::class, 'inativarPastoral'])->name('pastorais.inativar');
Route::post('/pastorais/{pastoral}/delete-image', [PastoralController::class, 'excluirImagem'])->name('pastorais.deleteImage');
Route::put('/pastorais/ativar/{id}', [PastoralController::class, 'ativarPastoral'])->name('pastorais.ativar');

Route::get('/eventos', [EventoController::class, 'consultarEvento'])->name('eventos.index');;
Route::post('/eventos', [EventoController::class, 'cadastrarEvento'])->name('eventos.store');
Route::put('/eventos/{evento}', [EventoController::class, 'editarEvento'])->name('eventos.editarEvento');
Route::post('/eventos/inativar', [EventoController::class, 'inativarEvento'])->name('eventos.inativar');
Route::put('/eventos/{id}/ativar', [EventoController::class, 'ativarEvento'])->name('eventos.ativar');
Route::delete('/eventos/{id}', [EventoController::class, 'excluirEvento'])->name('eventos.softDelete');

Route::get('/informacoes', [InformacoesController::class, 'consultarInformacoes'])->name('informacoes.index');
Route::post('/horarios/store', [HorarioController::class, 'cadastrarHorario'])->name('horarios.store');
Route::delete('/horarios/{id}', [HorarioController::class, 'excluirHorario'])->name('horarios.destroy');
Route::post('/contatos/store', [ContatoController::class, 'cadastrarContato'])->name('contatos.store');
Route::delete('/contatos/{tipo}', [ContatoController::class, 'excluirContato'])->name('contatos.destroy');

Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');
Route::get('/users/{user}/edit', [UserController::class, 'edit'])->name('edit-user');

//Rotas para informações das pastorais, eventos, horarios, contatos e avisos em JSON
Route::get('/pastoraisapi', [PastoralController::class, 'carregarPastoraisApp']);
Route::get('/dizimoapi', [DizimoController::class, 'carregarDizimoApp']);
Route::get('/doacaoapi', [DoacaoController::class, 'carregarDoacaoApp']);
Route::get('/eventosapi', [EventoController::class, 'carregarEventosAtivosApp']);
Route::get('/horariosapi', [HorarioController::class, 'carregarHorariosApp']);
Route::get('/contatosapi', [ContatoController::class, 'carregarContatoApp']);
Route::get('/avisosapi', [AvisoController::class, 'carregarAvisosApp']);

Route::get('/csrf-token', function () {
    return response()->json(['csrfToken' => csrf_token()]);
});
require __DIR__ . '/auth.php';
