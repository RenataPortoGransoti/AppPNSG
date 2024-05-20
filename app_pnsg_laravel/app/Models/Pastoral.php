<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pastoral extends Model
{
    use HasFactory;

    protected $table = 'pastorais'; //nome da tabela
    protected $fillable = ['nome', 'descricao', 'imagem'];
}
