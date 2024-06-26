<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Http\Exceptions\PostTooLargeException;

class HandleFileUploadExceptions
{
    public function handle($request, Closure $next)
    {
        try {
            return $next($request);
        } catch (PostTooLargeException $exception) {
            return Redirect::back()->withInput()->withErrors(['photo' => 'A imagem é muito grande.']);
        }
    }
}
