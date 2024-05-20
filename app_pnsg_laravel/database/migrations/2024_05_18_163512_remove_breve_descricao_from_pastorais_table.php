<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class RemoveBreveDescricaoFromPastoraisTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::table('pastorais', function (Blueprint $table) {
            $table->dropColumn('breve_descricao');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::table('pastorais', function (Blueprint $table) {
            $table->string('breve_descricao')->nullable();
        });
    }
}

