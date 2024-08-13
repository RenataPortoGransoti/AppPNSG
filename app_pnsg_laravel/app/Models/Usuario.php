<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Usuario extends Model
{
    use HasFactory;

    protected $table = 'usuarios';

    protected $fillable = [
        'nome',
        'cpf',
        'celular',
        'email',
        'dataNascimento',
        'tipo',
    ];

    public function secretario()
    {
        return $this->hasOne(Secretario::class, 'id_usuario');
    }

    public function paroquiano()
    {
        return $this->hasOne(Paroquiano::class, 'id_usuario');
    }
}
