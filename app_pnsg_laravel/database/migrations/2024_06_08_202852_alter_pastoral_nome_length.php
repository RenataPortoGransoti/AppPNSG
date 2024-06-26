<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterPastoralNomeLength extends Migration
{
    public function up()
    {
        Schema::table('pastorais', function (Blueprint $table) {
            $table->string('nome', 60)->change();
        });
    }

    public function down()
    {
        Schema::table('pastorais', function (Blueprint $table) {
            $table->string('nome', 255)->change();
        });
    }
}
