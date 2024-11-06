<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('pastorais', function (Blueprint $table) {
            $table->id();
            $table->string('nome');
            $table->text('breve_descricao')->nullable();
            $table->text('descricao')->nullable();
            $table->string('imagem')->nullable();
            $table->unsignedBigInteger('secretario_id')->nullable();
            $table->foreign('secretario_id')->references('id')->on('users')->onDelete('set null'); 
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('pastorais');
    }
};
