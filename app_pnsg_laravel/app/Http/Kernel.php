<?php

namespace App\Http;

use Illuminate\Foundation\Http\Kernel as HttpKernel;

class Kernel extends HttpKernel
{
    protected $routeMiddleware = [
        // Outros middlewares
        'handle.file.upload.exceptions' => \App\Http\Middleware\HandleFileUploadExceptions::class,
    ];
}
