<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEventosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('eventos', function (Blueprint $table) {
            $table->id();
            $table->string('nome_evento', 50);
            $table->dateTime('data_inicio');
            $table->dateTime('data_fim')->nullable();
            $table->string('local', 100);
            $table->boolean('ativo')->default(1);
            $table->softDeletes();
            $table->unsignedBigInteger('secretario_id')->nullable();
            $table->foreign('secretario_id')->references('id')->on('users')->onDelete('set null');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('eventos');
    }
}
