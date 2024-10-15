<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DizimoController;
use App\Http\Controllers\DoacaoController;
use App\Http\Controllers\PastoralController;
use App\Http\Controllers\EventoController;
use App\Http\Controllers\HorarioController;
use App\Http\Controllers\ContatoController;
use App\Http\Controllers\ParoquianoController;
use App\Http\Controllers\AvisoController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
//Rotas para informações das pastorais, eventos, horarios, contatos e avisos em JSON
Route::get('/pastoraisapi', [PastoralController::class, 'carregarPastoraisApp']);
Route::get('/dizimoapi', [DizimoController::class, 'carregarDizimoApp']);
Route::get('/doacaoapi', [DoacaoController::class, 'carregarDoacaoApp']);
Route::get('/eventosapi', [EventoController::class, 'carregarEventosAtivosApp']);
Route::get('/horariosapi', [HorarioController::class, 'carregarHorariosApp']);
Route::get('/contatosapi', [ContatoController::class, 'carregarContatoApp']);
Route::get('/avisosapi', [AvisoController::class, 'carregarAvisosApp']);
Route::post('/registrar/paroquiano', [ParoquianoController::class, 'registrarParoquiano']);

Route::post('/autenticate', [\App\Http\Controllers\Api\AuthController::class, "login"]);

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
