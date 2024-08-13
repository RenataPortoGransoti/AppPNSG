<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Paroquiano extends Model
{
    use HasFactory;

    protected $table = 'paroquianos';

    protected $fillable = [
        'id_usuario',
        'pastoral_id',
        'ruaEndereco',
        'bairroEndereco',
        'numeroEndereco',
        'estadoCivil',
        'dataCasamento',
        'dizimista',
        'numeroDizimista',
    ];

    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'id_usuario');
    }
}
