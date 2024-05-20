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


Route::get('/admin/inicio', function () {
    return view('admin.inicio');
});

Route::get('/pastorais', function () {
    return view('pastorais');
});

Route::get('/informacoes', function () {
    return view('informacoes');
});


class InformacoesController extends Controller
{
    public function index()
    {
        // Carregar os horários (substitua isso pela lógica real para carregar os horários)
        $horarios = Horario::all();

        // Retornar a visão 'informacoes' com os horários
        return view('informacoes.index', ['horarios' => $horarios]);
    }
}


Route::get('/pastorais', [PastoralController::class, 'index'])->name('pastorais.index');
Route::post('/pastorais', [PastoralController::class, 'store'])->name('pastorais.store');
Route::put('/pastorais/{pastoral}', [PastoralController::class, 'update'])->name('pastorais.update');
Route::post('/pastorais/inativar', [PastoralController::class, 'inativar'])->name('pastorais.inativar');
Route::post('pastorais/{pastoral}/delete-image', [PastoralController::class, 'deleteImage'])->name('pastorais.deleteImage');
Route::put('/pastorais/ativar/{id}', [PastoralController::class, 'ativar'])->name('pastorais.ativar');


require __DIR__.'/auth.php';


//Rota para informações das pastorais em JSON
Route::get('/pastoraisapi', [PastoralController::class, 'indexApi']);

