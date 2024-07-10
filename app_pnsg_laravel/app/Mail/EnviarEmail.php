<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class EnviarEmail extends Mailable
{
    use Queueable, SerializesModels;

    public $nomeCompleto;
    public $email;
    public $celular;
    public $mensagem;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($nomeCompleto, $email, $celular, $mensagem)
    {
        $this->nomeCompleto = $nomeCompleto;
        $this->email = $email;
        $this->celular = $celular;
        $this->mensagem = $mensagem;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->subject('Nova mensagem recebida!')
            ->view('emails.enviar_email')
            ->with([
                'nomeCompleto' => $this->nomeCompleto,
                'email' => $this->email,
                'celular' => $this->celular,
                'mensagem' => $this->mensagem,
            ]);
    }
}
