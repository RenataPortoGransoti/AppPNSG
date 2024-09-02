@extends('layouts.app')

<head>
    <title>Início | Painel Admin</title>
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body>
    @section('content')
        <div class="container mx-auto max-w-4xl">
            <h1 class="text-center font-semibold text-4xl my-6">AVISOS PAROQUIAIS</h1>
            <div class="container mx-auto mt-4 mb-8">
                <div class="flex justify-center">
                    <div class="w-full md:w-2/3">
                        <div class="px-8 py-4 bg-white shadow rounded-lg">
                            <h1 class="mb-4 text-center text-xl">Editar avisos</h1>

                            <!-- Formulário de Avisos -->
                            <form action="{{ route('avisos.store') }}" method="POST" class="mb-4">
                                @csrf
                                <div class="my-5">
                                    <div class="card bg-white shadow rounded-lg overflow-hidden">
                                        <div
                                            class="card-header flex items-center justify-between bg-[#036896] text-white p-4">
                                            <h3 class="text-center w-full">Avisos Paroquiais</h3>
                                            <i class="bi bi-dash toggle-icon cursor-pointer text-white text-2xl"></i>
                                        </div>
                                        <div class="card-body p-4" id="avisos-container">
                                            @foreach ($avisos as $aviso)
                                                <div class="my-2 flex items-center">
                                                    <input type="text" name="avisos[]" value="{{ $aviso->aviso }}"
                                                        class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm px-1">
                                                    <input type="hidden" name="ids[]" value="{{ $aviso->id }}">
                                                    <button type="button" class="relative ml-2 group"
                                                        onclick="showExcluirModal({{ $aviso->id }})">
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
                                                <input type="text" name="avisos[]"
                                                    class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                                <input type="hidden" name="ids[]" value="">
                                                <button type="button"
                                                    class="relative add-aviso-btn ml-2 text-green-500 group"><i
                                                        class="bi bi-plus text-green-500 group-hover:text-gray-800 transform group-hover:scale-110 transition-transform duration-300"></i>
                                                    <span
                                                        class="absolute bottom-full left-0.5 transform -translate-x-1/2 mb-2 w-20 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                                        Adicionar
                                                    </span></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="text-white px-4 py-3 text-center">
                                    <button type="submit" id="submitBtn"
                                        class="btn w-3/12 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Excluir Aviso-->
        <div id="excluirModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
            <div class="bg-white w-1/3 p-8 rounded-md">
                <h3 class="text-[#960316] text-lg font-bold text-center mb-4">Excluir Aviso?</h3>
                <p class="mt-2 mb-4">Tem certeza de que deseja excluir? O Aviso não aparecerá mais na lista de avisos.</p>
                <div class="flex justify-center items-center align-center">
                    <button id="btnExcluirFecharModal" onclick="hideExcluirModal()"
                        class="px-4 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black text-white border border-[#036896] rounded-xl mr-2">Voltar</button>
                    <form id="formExcluirAviso" method="POST">
                        @csrf
                        @method('DELETE')
                        <input type="hidden" id="excluirAvisoId" name="aviso_id">
                        <button type="submit"
                            class="mt-4 px-4 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black text-white border border-[#960316] rounded-xl">Confirmar</button>
                    </form>
                </div>
            </div>
        </div>
    @endsection
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
                if (event.target.closest('.add-aviso-btn')) {
                    const container = event.target.closest('.card-body');
                    const newAviso = document.createElement('div');
                    newAviso.classList.add('my-2', 'flex', 'items-center');
                    newAviso.innerHTML = `
                            <input type="text" name="${container.id.replace('container', '')}[]" data-id="" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                            <input type="hidden" name="ids_${container.id.replace('container', '')}[]" value="">
                            <button type="button" class="remove-aviso-btn ml-2 text-red-500"><i class="bi bi-x"></i></button>
                        `;
                    container.appendChild(newAviso);
                }

                if (event.target.closest('.remove-aviso-btn')) {
                    const aviso = event.target.closest('.my-2');
                    aviso.remove();
                }

                if (event.target.closest('.remove-aviso')) {
                    const tipo = event.target.closest('.remove-aviso').dataset.tipo;
                    fetch(`{{ route('avisos.destroy', '') }}/${tipo}`, {
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
            const excluirAvisoId = document.getElementById('excluirAvisoId');
            excluirAvisoId.value = id;
            const formExcluirAviso = document.getElementById('formExcluirAviso');
            formExcluirAviso.action = `/avisos/${id}`;
            excluirModal.classList.remove('hidden');
        }

        function hideExcluirModal() {
            const excluirModal = document.getElementById('excluirModal');
            excluirModal.classList.add('hidden');
        }
    </script>

</body>
