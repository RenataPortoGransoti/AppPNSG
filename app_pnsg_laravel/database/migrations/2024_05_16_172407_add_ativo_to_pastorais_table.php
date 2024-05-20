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
    Schema::table('pastorais', function (Blueprint $table) {
        $table->boolean('ativo')->default(true);
    });
}

public function down()
{
    Schema::table('pastorais', function (Blueprint $table) {
        $table->dropColumn('ativo');
    });
}

};
