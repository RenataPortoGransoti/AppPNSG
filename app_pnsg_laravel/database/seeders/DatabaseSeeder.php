<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Pastoral;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {

        DB::table('pastorais')->insert([
            'nome' => 'Acolhida',
            'descricao' => 'Descrição da Pastoral da Acolhida',
            'imagem' => null
        ]);
        DB::table('pastorais')->insert([
            'nome' => 'Acólitos',
            'descricao' => null,
            'imagem' => null
        ]);
        DB::table('pastorais')->insert([
            'nome' => 'Apostolado da oração',
            'descricao' => null,
            'imagem' => null
        ]);


        DB::table('users')->insert([
            'nome' => 'Secretário',
            'cpf' => '06230749904',
            'celular' => '4333421276',
            'email' => 'admin@email.com',
            'dataNascimento' => '1999-12-12',
            'tipo' => 'secretario',
            'password' => bcrypt('admin123'),
        ]);

    }
}
