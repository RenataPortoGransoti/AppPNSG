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
        'ativo',
        'secretario_id',
        'created_at',
        'updated_at',
        'deleted_at'
    ];

    public function secretario()
    {
        return $this->belongsTo(Secretario::class);
    }
}
