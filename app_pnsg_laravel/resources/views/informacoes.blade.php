@extends('layouts.app')

<head>
    <title>Informações | Painel Admin</title>
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">
</head>

<body>
    @section('content')
        <div class="container mx-auto max-w-4xl">
            <h1 class="text-center font-semibold text-4xl">INFORMAÇÕES GERAIS</h1>
            <div class="container mx-auto mt-4 mb-8">
                <div class="flex justify-center">
                    <div class="w-full md:w-2/3">
                        <div class="px-8 py-4 bg-white shadow rounded-lg">
                            <h1 class="mb-4 text-center text-xl">Editar Informações</h1>
                            <form action="{{ route('contatos.store') }}" method="POST">
                                @csrf
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <div class="space-y-3">
                                        <div>
                                            <label for="contato" class="block text-gray-700">Contato</label>
                                            <div class="flex">
                                                <input type="text" id="contato" name="contato"
                                                    value="{{ $contatosMap['contato']->valor ?? '' }}"
                                                    class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                                <button type="button" class="ml-2 text-red-500 remove-contato"
                                                    data-tipo="contato"><i class="bi bi-x"></i></button>
                                            </div>
                                        </div>
                                        <div>
                                            <label for="instagram" class="block text-gray-700">Instagram</label>
                                            <div class="flex">
                                                <input type="text" id="instagram" name="instagram"
                                                    value="{{ $contatosMap['instagram']->valor ?? '' }}"
                                                    class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                                <button type="button" class="ml-2 text-red-500 remove-contato"
                                                    data-tipo="instagram"><i class="bi bi-x"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="space-y-3">
                                        <div>
                                            <label for="email" class="block text-gray-700">E-mail</label>
                                            <div class="flex">
                                                <input type="email" id="email" name="email"
                                                    value="{{ $contatosMap['email']->valor ?? '' }}"
                                                    class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                                <button type="button" class="ml-2 text-red-500 remove-contato"
                                                    data-tipo="email"><i class="bi bi-x"></i></button>
                                            </div>
                                        </div>
                                        <div>
                                            <label for="facebook" class="block text-gray-700">Facebook</label>
                                            <div class="flex">
                                                <input type="text" id="facebook" name="facebook"
                                                    value="{{ $contatosMap['facebook']->valor ?? '' }}"
                                                    class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                                <button type="button" class="ml-2 text-red-500 remove-contato"
                                                    data-tipo="facebook"><i class="bi bi-x"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-white px-4 py-3 text-center">
                                    <button type="button"
                                        class="btn w-3/12 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black border border-[#960316] rounded-xl"
                                        onclick="showConfirmationModal()">Cancelar</button>
                                    <button type="submit" id="submitBtn"
                                        class="btn w-3/12 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
                                </div>
                            </form>
                            <form action="{{ route('horarios.store') }}" method="POST">
                                @csrf
                                @foreach (['secretaria', 'missa', 'confissão'] as $tipo)
                                    <div class="my-5">
                                        <div class="card bg-white shadow rounded-lg overflow-hidden">
                                            <div
                                                class="card-header flex items-center justify-between bg-[#036896] text-white p-4">
                                                <h3 class="text-center w-full">Horários {{ ucfirst($tipo) }}</h3>
                                                <i class="bi bi-dash toggle-icon cursor-pointer text-white text-2xl"></i>
                                            </div>
                                            <div class="card-body p-4" id="horarios-container-{{ $tipo }}">
                                                @foreach ($horarios[$tipo] as $horario)
                                                    <div class="my-2 flex items-center">
                                                        <input type="text" name="horarios_{{ $tipo }}[]"
                                                            value="{{ $horario->descricao }}" data-id="{{ $horario->id }}"
                                                            class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                                        <input type="hidden" name="ids_{{ $tipo }}[]"
                                                            value="{{ $horario->id }}">
                                                        <button type="button"
                                                            class="remove-horario-btn ml-2 text-red-500"><i
                                                                class="bi bi-x"></i></button>
                                                    </div>
                                                @endforeach
                                                <div class="my-2 flex items-center">
                                                    <input type="text" name="horarios_{{ $tipo }}[]"
                                                        data-id=""
                                                        class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                                    <input type="hidden" name="ids_{{ $tipo }}[]" value="">
                                                    <button type="button" class="add-horario-btn ml-2 text-green-500"><i
                                                            class="bi bi-plus"></i></button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                @endforeach

                                <div class="text-white px-4 py-3 text-center">
                                    <button type="button"
                                        class="btn w-3/12 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black border border-[#960316] rounded-xl"
                                        onclick="showConfirmationModal()">Cancelar</button>
                                    <button type="submit" id="submitBtn"
                                        class="btn w-3/12 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', (event) => {
                document.querySelectorAll('.toggle-icon').forEach(icon => {
                    icon.addEventListener('click', () => {
                        const cardBody = icon.closest('.card').querySelector('.card-body');
                        if (cardBody.style.display === 'none' || cardBody.style.display === '') {
                            cardBody.style.display = 'block';
                            icon.classList.remove('bi-plus');
                            icon.classList.add('bi-dash');
                        } else {
                            cardBody.style.display = 'none';
                            icon.classList.remove('bi-dash');
                            icon.classList.add('bi-plus');
                        }
                    });
                });

                document.addEventListener('click', (event) => {
                    if (event.target.closest('.add-horario-btn')) {
                        const container = event.target.closest('.card-body');
                        const newHorario = document.createElement('div');
                        newHorario.classList.add('my-2', 'flex', 'items-center');
                        newHorario.innerHTML = `
                            <input type="text" name="${container.id.replace('container', '')}[]" data-id="" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                            <input type="hidden" name="ids_${container.id.replace('container', '')}[]" value="">
                            <button type="button" class="remove-horario-btn ml-2 text-red-500"><i class="bi bi-x"></i></button>
                        `;
                        container.appendChild(newHorario);
                    }

                    if (event.target.closest('.remove-horario-btn')) {
                        const horario = event.target.closest('.my-2');
                        horario.remove();
                    }

                    if (event.target.closest('.remove-contato')) {
                        const tipo = event.target.closest('.remove-contato').dataset.tipo;
                        fetch(`{{ route('contatos.destroy', '') }}/${tipo}`, {
                            method: 'DELETE',
                            headers: {
                                'X-CSRF-TOKEN': '{{ csrf_token() }}'
                            }
                        }).then(response => {
                            if (response.ok) {
                                const input = document.querySelector(`input[name="${tipo}"]`);
                                input.value = '';
                            }
                        });
                    }
                });
            });
        </script>
    @endsection
</body>
