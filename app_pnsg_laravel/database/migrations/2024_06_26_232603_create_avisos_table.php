<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAvisosTable extends Migration
{
    public function up()
    {
        Schema::create('avisos', function (Blueprint $table) {
            $table->id();
            $table->string('aviso', 100);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('avisos');
    }
}
