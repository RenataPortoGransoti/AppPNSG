<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Secretario extends Model
{
    use HasFactory;

    protected $table = 'secretarios';

    protected $fillable = [
        'id_usuario',
        'codSecretario',
    ];

    public function usuario()
    {
        return $this->belongsTo(Usuario::class, 'id_usuario');
    }
}
