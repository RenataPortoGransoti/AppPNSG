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
            'nome' => 'Pastoral da Acolhida',
            'descricao' => 'Descrição da Pastoral da Acolhida',
            'imagem' => null
        ]);

        DB::table('pastorais')->insert([
            'nome' => 'Ministério de Leitores',
            'descricao' => 'Descrição Leitores',
            'imagem' => 'images/1716139135.jpg'
        ]);


        // DB::table('users')->insert([
        //     'nome' => 'Secretário',
        //     'email' => 'admin@email.com',
        //     'cpf' => '06230749904',
        //     'celular' => '4333421276',
        //     'dataNascimento' => '1999-12-12',
        //     'tipo' => 'secretario',
        //     'senha' => bcrypt('admin123'),
        // ]);
    }
}
