<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Informações | Painel Admin</title>
    <link rel="icon" type="image/x-icon" href="{{ asset('build/assets/brasaoparoquia_logo.jpg') }}">
    <script src="https://cdn.tailwindcss.com"></script>

</head>

<body>
    <main class="app-main">
        <div class="container mx-auto mt-1 mb-5 pt-2">
            <div class="flex justify-center">
                <div class="w-full md:w-3/4 lg:w-1/2">
                    <div class="bg-white shadow-md rounded-lg p-4">
                        <h1 class="mb-4 text-center text-xl font-bold">Editar Informações</h1>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label for="contato" class="block mb-1">Contato</label>
                                <input type="text" id="contato" class="form-input">
                            </div>
                            <div>
                                <label for="instagram" class="block mb-1">Instagram</label>
                                <input type="text" id="instagram" class="form-input">
                            </div>
                            <div>
                                <label for="email" class="block mb-1">E-mail</label>
                                <input type="email" id="email" class="form-input">
                            </div>
                            <div>
                                <label for="facebook" class="block mb-1">Facebook</label>
                                <input type="text" id="facebook" class="form-input">
                            </div>
                        </div>
                    </div>

                    <div class="mt-4">
                        <div class="bg-white shadow-md rounded-lg">
                            <div
                                class="flex items-center justify-between bg-blue-900 text-white rounded-t-lg px-4 py-2">
                                <h3 class="text-center">Horários Secretaria Paroquial</h3>
                                <button type="button" class="btn" data-toggle="collapse">
                                    <i class="bi bi-plus-lg"></i>
                                    <i class="bi bi-dash-lg hidden"></i>
                                </button>
                            </div>
                            <div class="collapse">
                                <div class="py-2 px-4">
                                    <input type="text" value="Segunda à Sexta: 8h às 12h e 14h às 18h"
                                        class="form-input">
                                </div>
                                <hr class="my-2">
                                <div class="py-2 px-4">
                                    <input type="text" value="Sábado: 14h às 18h" class="form-input">
                                </div>
                            </div>
                        </div>

                        <div class="mt-4">
                            <div class="bg-white shadow-md rounded-lg">
                                <div
                                    class="flex items-center justify-between bg-blue-900 text-white rounded-t-lg px-4 py-2">
                                    <h3 class="text-center">Horários Missa</h3>
                                    <button type="button" class="btn" data-toggle="collapse">
                                        <i class="bi bi-plus-lg"></i>
                                        <i class="bi bi-dash-lg hidden"></i>
                                    </button>
                                </div>
                                <div class="collapse">
                                    @foreach ($horarios as $horario)
                                        @if ($horario['titulo'] === 'Horários Missa')
                                            @foreach ($horario['texto'] as $texto)
                                                <div class="py-2 px-4">
                                                    <input type="text" value="{{ $texto }}"
                                                        class="form-input">
                                                </div>
                                            @endforeach
                                        @endif
                                    @endforeach
                                </div>
                            </div>

                            <div class="mt-4">
                                <div class="bg-white shadow-md rounded-lg">
                                    <div
                                        class="flex items-center justify-between bg-blue-900 text-white rounded-t-lg px-4 py-2">
                                        <h3 class="text-center">Horários Confissões</h3>
                                        <button type="button" class="btn" data-toggle="collapse">
                                            <i class="bi bi-plus-lg"></i>
                                            <i class="bi bi-dash-lg hidden"></i>
                                        </button>
                                    </div>
                                    <div class="collapse">
                                        <div class="py-2 px-4">
                                            <input type="text" value="Terça e Quinta: 17:30h às 18:20h"
                                                class="form-input">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>


</body>

</html>
