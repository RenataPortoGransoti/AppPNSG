@extends('layouts.app')

<head>
    <title>Informações | Painel Admin</title>
    <link rel="icon" type="image/x-icon" href="{{ asset('storage/images/brasaoparoquia_logo.jpg?v=2') }}" />
</head>

<body>
    @section('content')
        <div class="container mx-auto max-w-4xl">
            @if (session('success'))
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4"
                    role="alert">
                    <strong class="font-bold">Sucesso!</strong>
                    <span class="block sm:inline">{{ session('success') }}</span>
                    <button type="button"
                        class="absolute top-0 right-0 mt-1 mr-2 text-green-700 hover:text-green-500 focus:outline-none"
                        onclick="this.parentElement.style.display='none'">
                        <span class="sr-only">Fechar</span>
                        <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                                d="M12.707 7.293a1 1 0 0 1 1.414 1.414L11.414 11l2.707 2.293a1 1 0 1 1-1.414 1.414L10 12.414l-2.293 2.293a1 1 0 0 1-1.414-1.414L8.586 11 5.879 8.707a1 1 0 0 1 1.414-1.414L10 9.586l2.293-2.293z"
                                clip-rule="evenodd" />
                        </svg>
                    </button>
                </div>
            @endif
            <h1 class="text-center font-semibold text-4xl my-6">INFORMAÇÕES GERAIS</h1>
            <div class="container mx-auto mt-4 mb-8">
                <div class="flex justify-center ">
                    <div class="w-full md:w-2/3">
                        {{-- div contato --}}
                        <div class="px-8 py-4 bg-white shadow-xl rounded-lg mb-10 border border-[#036896] ">
                            <h1 class="mb-4 text-center text-xl">Editar Informações de Contato</h1>
                            <div class="flex justify-end">
                                <i class="bi bi-dash toggle-icon cursor-pointer text-2xl"></i>
                            </div>
                            <div class="toggle-content">
                                <form action="{{ route('contatos.store') }}" method="POST">
                                    @csrf
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <div class="space-y-3">
                                            <div>
                                                <label for="contato" class="block text-gray-700">Contato</label>
                                                <div class="flex">
                                                    <input type="text" id="contato" name="contato"
                                                        value="{{ old('contato', $contatosMap['contato'][0]->valor ?? '') }}"
                                                        class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm px-1">
                                                    <button type="button"
                                                        class="relative ml-2 text-red-500 remove-contato group "
                                                        data-tipo="contato"><i
                                                            class="bi bi-x text-red-500 group-hover:text-[#FA9DAA] transform group-hover:scale-110 transition-transform duration-300"></i>
                                                        <span
                                                            class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-20 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                                            Excluir
                                                        </span></button>
                                                </div>
                                            </div>
                                            <div>
                                                <label for="instagram" class="block text-gray-700">Instagram</label>
                                                <div class="flex">
                                                    <input type="text" id="instagram" name="instagram"
                                                        value="{{ old('instagram', $contatosMap['instagram'][0]->valor ?? '') }}"
                                                        class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm px-1">
                                                    <button type="button"
                                                        class="relative ml-2 text-red-500 remove-contato group"
                                                        data-tipo="instagram"><i
                                                            class="bi bi-x text-red-500 group-hover:text-[#FA9DAA] transform group-hover:scale-110 transition-transform duration-300"></i>
                                                        <span
                                                            class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-20 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                                            Excluir
                                                        </span></button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="space-y-3">
                                            <div>
                                                <label for="email" class="block text-gray-700">E-mail</label>
                                                <div class="flex">
                                                    <input type="email" id="email" name="email"
                                                        value="{{ old('email', $contatosMap['email'][0]->valor ?? '') }}"
                                                        class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm px-1">
                                                    <button type="button"
                                                        class="relative ml-2 text-red-500 remove-contato group"
                                                        data-tipo="email"><i
                                                            class="bi bi-x text-red-500 group-hover:text-[#FA9DAA] transform group-hover:scale-110 transition-transform duration-300"></i>
                                                        <span
                                                            class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-20 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                                            Excluir
                                                        </span></button>
                                                </div>
                                            </div>
                                            <div>
                                                <label for="facebook" class="block text-gray-700">Facebook</label>
                                                <div class="flex">
                                                    <input type="text" id="facebook" name="facebook"
                                                        value="{{ old('facebook', $contatosMap['facebook'][0]->valor ?? '') }}"
                                                        class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm px-1">
                                                    <button type="button"
                                                        class="relative ml-2 text-red-500 remove-contato group"
                                                        data-tipo="facebook"><i
                                                            class="bi bi-x text-red-500 group-hover:text-[#FA9DAA] transform group-hover:scale-110 transition-transform duration-300"></i>
                                                        <span
                                                            class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-20 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                                            Excluir
                                                        </span></button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-white px-4 py-3 text-center">
                                        <button type="submit" id="submitBtn"
                                            class="btn w-3/12 mt-4 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        {{-- div horarios --}}
                        <div class="px-8 py-4 bg-white shadow-xl rounded-lg mb-10 border border-[#036896]">
                            <h1 class="mb-4 text-center text-xl">Editar Informações de Horários</h1>
                            <div class="flex justify-end">
                                <i class="bi bi-dash toggle-icon cursor-pointer text-2xl"></i>
                            </div>
                            <div class="toggle-content">
                                <form action="{{ route('horarios.store') }}" method="POST">
                                    @csrf
                                    @foreach (['secretaria', 'missa', 'confissão'] as $tipo)
                                        <div class="my-5">
                                            <div class="card bg-white shadow rounded-lg overflow-hidden">
                                                <div
                                                    class="card-header flex items-center justify-between bg-[#036896] text-white p-4">
                                                    <h3 class="text-center w-full">Horários {{ ucfirst($tipo) }}</h3>
                                                    <i
                                                        class="bi bi-plus toggle-icon cursor-pointer text-white text-2xl"></i>
                                                </div>
                                                <div class="card-body p-4" id="horarios-container-{{ $tipo }}"
                                                    hidden>
                                                    @foreach ($horarios[$tipo] as $horario)
                                                        <div class="my-2 flex items-center">
                                                            <input type="text" name="horarios_{{ $tipo }}[]"
                                                                value="{{ $horario->descricao }}"
                                                                data-id="{{ $horario->id }}"
                                                                class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm px-1">
                                                            <input type="hidden" name="ids_{{ $tipo }}[]"
                                                                value="{{ $horario->id }}">
                                                            <button type="button" class="relative ml-2 group"
                                                                onclick="showExcluirModal({{ $horario->id }})">

                                                                <i
                                                                    class="bi bi-x text-red-500 group-hover:text-[#FA9DAA] transform group-hover:scale-110 transition-transform duration-300"></i>
                                                                <span
                                                                    class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-20 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                                                    Excluir
                                                                </span>
                                                            </button>
                                                        </div>
                                                    @endforeach
                                                    <div class="my-2 flex items-center">
                                                        <input type="text" name="horarios_{{ $tipo }}[]"
                                                            data-id=""
                                                            class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm px-1">
                                                        <input type="hidden" name="ids_{{ $tipo }}[]"
                                                            value="">
                                                        <button type="button"
                                                            class="relative add-horario-btn ml-2 text-green-500 group"><i
                                                                class="bi bi-plus text-green-500 group-hover:text-gray-800 transform group-hover:scale-110 transition-transform duration-300"></i>
                                                            <span
                                                                class=" absolute bottom-full  left-0.5 transform -translate-x-1/2 mb-2 w-20 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                                                Adicionar
                                                            </span></button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    @endforeach

                                    <div class="text-white px-4 py-3 text-center">
                                        <button type="submit" id="submitBtn"
                                            class="btn w-3/12 mt-2 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Excluir Horário-->
        <div id="excluirModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
            <div class="bg-white w-1/3 p-8 rounded-md">
                <h3 class="text-[#960316] text-lg font-bold text-center mb-4">Excluir Horário?</h3>
                <p class="mt-2 mb-4">Tem certeza de que deseja excluir? O horário não aparecerá mais na lista de horários.
                </p>
                <div class="flex justify-center items-center align-center">
                    <button id="btnExcluirFecharModal"
                        class="px-4 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black text-white border border-[#036896] rounded-xl mr-2">Voltar</button>
                    <form id="formExcluirHorario" method="POST">
                        @csrf
                        @method('DELETE')
                        <input type="hidden" id="excluirHorarioId" name="horario_id">
                        <button type="submit"
                            class="mt-4 px-4 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black text-white border border-[#960316] rounded-xl">Confirmar</button>
                    </form>
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
                        const tipo = container.id.replace('horarios-container-', '');
                        const newHorario = document.createElement('div');
                        newHorario.classList.add('my-2', 'flex', 'items-center');
                        newHorario.innerHTML = `
                            <input type="text"  name="horarios_${tipo}[]" data-id="" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                            <input type="hidden" name="ids_${tipo}[]" value="">
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

            function showExcluirModal(id) {
                const excluirModal = document.getElementById('excluirModal');
                const excluirHorarioId = document.getElementById('excluirHorarioId');
                excluirHorarioId.value = id;
                const formExcluirHorario = document.getElementById('formExcluirHorario');
                formExcluirHorario.action = `/horarios/${id}`;
                excluirModal.classList.remove('hidden');
            }

            function hideExcluirModal() {
                const excluirModal = document.getElementById('excluirModal');
                excluirModal.classList.add('hidden');
            }
            document.getElementById('btnExcluirFecharModal').addEventListener('click', hideExcluirModal);
        </script>
    @endsection
</body>
