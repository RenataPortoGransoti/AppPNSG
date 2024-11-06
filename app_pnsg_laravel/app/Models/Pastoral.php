<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pastoral extends Model
{
    use HasFactory;

    protected $table = 'pastorais';
    protected $fillable = ['nome', 'descricao', 'imagem', 'secretario_id'];

    public function secretario()
    {
        return $this->belongsTo(User::class, 'secretario_id');
    }
}
