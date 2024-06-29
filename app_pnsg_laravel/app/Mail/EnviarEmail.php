<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;

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
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Nova mensagem!',
        );
    }
    /**
     * Build the message.
     *
     * @return $this
     */


    public function content(): Content
    {
        return new Content(
            view: 'emails.enviar_email',
        );
    }
}
