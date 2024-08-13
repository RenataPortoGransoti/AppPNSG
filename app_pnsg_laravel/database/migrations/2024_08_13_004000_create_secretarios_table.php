<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSecretariosTable extends Migration
{
    public function up()
    {
        Schema::create('secretarios', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_usuario')->constrained('usuarios')->onDelete('cascade');
            $table->string('codSecretario');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('secretarios');
    }
}
