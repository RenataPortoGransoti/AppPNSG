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
            <h1 class="text-center font-semibold text-4xl">AVISOS PAROQUIAIS</h1>
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
                                                        class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                                    <input type="hidden" name="ids[]" value="{{ $aviso->id }}">
                                                    <button type="button" class="remove-aviso-btn ml-2 text-red-500"><i
                                                            class="bi bi-x"></i></button>
                                                </div>
                                            @endforeach
                                            <div class="my-2 flex items-center">
                                                <input type="text" name="avisos[]"
                                                    class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                                <input type="hidden" name="ids[]" value="">
                                                <button type="button" class="add-aviso-btn ml-2 text-green-500"><i
                                                        class="bi bi-plus"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="text-white px-4 py-3 text-center">
                                    <button type="button"
                                        class="btn w-3/12 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black border border-[#960316] rounded-xl">Cancelar</button>
                                    <button type="submit" id="submitBtn"
                                        class="btn w-3/12 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div id="deleteModal" class="hidden fixed inset-0 z-50 overflow-y-auto">
            <div class="flex items-center justify-center min-h-screen px-4">
                <div class="bg-white rounded-lg overflow-hidden shadow-xl max-w-md w-full">
                    <div class="px-6 py-4">
                        <div class="text-lg font-medium text-gray-900">Confirmar Exclusão</div>
                        <div class="mt-4">
                            <p class="text-sm text-gray-600">Tem certeza de que deseja excluir este aviso?</p>
                        </div>
                    </div>
                    <div class="px-6 py-4 bg-gray-100 text-right">
                        <button type="button"
                            class="btn-close bg-gray-200 hover:bg-gray-300 text-gray-700 px-4 py-2 rounded mr-2">Cancelar</button>
                        <button type="button" class="bg-red-500 hover:bg-red-700 text-white px-4 py-2 rounded"
                            id="confirmDelete">Excluir</button>
                    </div>
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

            let avisoToDelete = null;
            const deleteModal = document.getElementById('deleteModal');
            const confirmDeleteButton = document.getElementById('confirmDelete');

            document.addEventListener('click', (event) => {
                if (event.target.closest('.add-aviso-btn')) {
                    const container = event.target.closest('.card-body');
                    const newAviso = document.createElement('div');
                    newAviso.classList.add('my-2', 'flex', 'items-center');
                    newAviso.innerHTML = `
                        <input type="text" name="avisos[]" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                        <input type="hidden" name="ids[]" value="">
                        <button type="button" class="remove-aviso-btn ml-2 text-red-500"><i class="bi bi-x"></i></button>
                    `;
                    container.appendChild(newAviso);
                }

                if (event.target.closest('.remove-aviso-btn')) {
                    avisoToDelete = event.target.closest('.my-2');
                    const avisoId = avisoToDelete.querySelector('input[name="ids[]"]').value;

                    if (avisoId) {
                        deleteModal.classList.remove('hidden');

                        confirmDeleteButton.onclick = () => {
                            fetch(`/avisos/${avisoId}`, {
                                method: 'DELETE',
                                headers: {
                                    'X-CSRF-TOKEN': '{{ csrf_token() }}',
                                    'Content-Type': 'application/json',
                                },
                            }).then(response => {
                                if (response.ok) {
                                    avisoToDelete.remove();
                                    deleteModal.classList.add('hidden');
                                } else {
                                    alert('Erro ao excluir o aviso.');
                                }
                            }).catch(error => {
                                alert('Erro ao excluir o aviso.');
                            });
                        };
                    } else {
                        avisoToDelete.remove();
                    }
                }

                if (event.target.closest('.btn-close')) {
                    deleteModal.classList.add('hidden');
                }
            });
        });
    </script>
</body>
