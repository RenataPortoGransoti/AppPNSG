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
            'nome' => 'Admin',
            'cpf' => '89993884090',
            'celular' => '4333421276',
            'email' => 'admin@email.com',
            'dataNascimento' => '1955-11-01',
            'tipo' => 'secretário(a)',
            'password' => bcrypt('admin123'),
        ]);
    }
}
