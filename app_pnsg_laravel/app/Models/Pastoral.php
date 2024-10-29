<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pastoral extends Model
{
    use HasFactory;

    protected $table = 'pastorais'; 
    protected $fillable = ['nome', 'descricao', 'imagem'];
}
