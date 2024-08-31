<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Dizimo extends Model
{
    use HasFactory;
    protected $table = 'dizimo';
    protected $fillable = ['chavePix', 'QRCode'];
}
