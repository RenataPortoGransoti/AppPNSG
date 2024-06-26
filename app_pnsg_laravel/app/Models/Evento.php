<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Evento extends Model
{
    use HasFactory, SoftDeletes;

    protected $dates = ['deleted_at'];

    protected $fillable = [
        'nome_evento',
        'data_inicio',
        'data_fim',
        'local',
        'descricao',
        'created_at',
        'updated_at',
        'ativo',
        'deleted_at'
    ];
}
