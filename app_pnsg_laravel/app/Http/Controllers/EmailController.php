<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Mail\EnviarEmail;
use Illuminate\Support\Facades\Validator;

class EmailController extends Controller
{
    protected $toEmail;

    public function __construct()
    {
        $this->toEmail = env('MAIL_SEND_TO');
    }

    public function sendEmail(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nomeCompleto' => 'required|string',
            'email' => 'required|email',
            'celular' => 'required|string',
            'mensagem' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 400);
        }

        $nomeCompleto = $request->nomeCompleto;
        $email = $request->email;
        $celular = $request->celular;
        $mensagem = $request->mensagem;

        Mail::to($this->toEmail)->send(new EnviarEmail($nomeCompleto, $email, $celular, $mensagem));
        Mail::to($email)->send(new EnviarEmail($nomeCompleto, $email, $celular, $mensagem));

        return response()->json(['message' => 'Email enviado com sucesso, aguarde o nosso contato!'], 200);
    }
}
