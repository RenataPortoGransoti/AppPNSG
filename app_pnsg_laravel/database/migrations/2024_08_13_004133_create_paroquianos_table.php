<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateParoquianosTable extends Migration
{
    public function up()
    {
        Schema::create('paroquianos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_usuario')->constrained('usuarios')->onDelete('cascade');
            $table->unsignedBigInteger('pastoral_id');
            $table->string('ruaEndereco');
            $table->string('bairroEndereco');
            $table->string('numeroEndereco');
            $table->string('estadoCivil');
            $table->date('dataCasamento');
            $table->boolean('dizimista');
            $table->integer('numeroDizimista');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('paroquianos');
    }
}
