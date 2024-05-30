<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Pastoral;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {

        DB::table('pastorais')->insert([
            'nome' => 'Pastoral da Acolhida',
            'descricao' => 'Descrição da Pastoral da Acolhida',
            'imagem' => null
        ]);

        DB::table('pastorais')->insert([
            'nome' => 'Ministério de Leitores',
            'descricao' => 'Descrição Leitores',
            'imagem' => 'images/1716139135.jpg'
        ]);
    }
}
