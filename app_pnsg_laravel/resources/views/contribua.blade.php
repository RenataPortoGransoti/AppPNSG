@extends('layouts.app')
<title>Contribua | Painel Admin</title>

@section('content')
    <div class="container mx-auto">
        <h1 class="text-center font-semibold text-4xl">CONTRIBUA</h1>
        <!-- Formulário de Envio de E-mails -->
        <div class="container mx-auto max-w-4xl mt-8">
            <div class="flex justify-center">
                <div class="w-full md:w-2/3">
                    <div class="px-8 py-4 bg-white shadow rounded-lg">
                        <h1 class="mb-4 text-center text-xl">Enviar E-mail</h1>

                        <form method="POST" action="{{ route('send-email') }}">
                            @csrf
                            <div>
                                <label for="nomeCompleto">Nome Completo:</label>
                                <input type="text" id="nomeCompleto" name="nomeCompleto" required>
                            </div>
                            <div>
                                <label for="email">E-mail:</label>
                                <input type="email" id="email" name="email" required>
                            </div>
                            <div>
                                <label for="celular">Celular:</label>
                                <input type="text" id="celular" name="celular" required>
                            </div>
                            <div>
                                <label for="mensagem">Mensagem:</label><br>
                                <textarea id="mensagem" name="mensagem" rows="4" required></textarea>
                            </div>
                            <button type="submit">Enviar E-mail</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
