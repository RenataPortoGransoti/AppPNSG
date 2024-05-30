@extends('layouts.app')
<title>Pastorais | Painel Admin</title>
@section('content')
    <main class="app-main flex-1 p-5 overflow-y-auto">

        <div class="container mx-auto">
            <h1 class="text-center font-semibold text-4xl">PASTORAIS</h1>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mt-8">
                <!--Pastorais Ativas-->
                <div class="my-4">
                    <div class="bg-white shadow-lg rounded-2xl border border-[#036896]">
                        <div class="text-center text-white px-4 py-3">
                            <button id="btnMostrarCard" class="btn px-4 py-3 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">
                                <span class="">CADASTRAR PASTORAL</span>
                            </button>
                        </div>
                        <!--DIV CARD PASTORAL-->
                        @foreach ($pastorais as $pastoral)
                        @if ($pastoral->ativo)
                        <div class="bg-white shadow-lg rounded-2xl mb-4 mx-5">
                            <div class="bg-[#9DDEFB] rounded-md py-3 px-4 flex justify-between items-center cursor-pointer border border-[#036896]">
                                <h4 class="font-semibold text-xl py-3 px-1">{{ $pastoral->nome }}</h4>
                                <div class="flex items-center">
                                    <button type="button" class="relative group btn btn-outline-primary me-2 px-5" onclick="toggleEditForm({{ $pastoral->id }})">
                                        <i class="bi bi-pencil text-gray-800 group-hover:text-blue-500 transform group-hover:scale-110 transition-transform duration-300"></i>
                                        <span class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-24 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                            Editar
                                        </span>
                                    </button>
                                    <button type="button" class="relative group btn btn-outline-danger pr-5" onclick="showExcluirModal({{ $pastoral->id }})">
                                        <i class="bi bi-trash text-gray-800 group-hover:text-red-500 transform group-hover:scale-110 transition-transform duration-300"></i>
                                        <span class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-24 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                            Inativar
                                        </span>
                                    </button>
                                </div>
                            </div>
                            <div id="editForm{{ $pastoral->id }}" class="hidden bg-white shadow-lg rounded-2xl p-4 mt-2">
                                <form action="{{ route('pastorais.update', $pastoral->id) }}" method="POST" enctype="multipart/form-data">
                                    @csrf
                                    @method('PUT')
                                    <div class="mb-3">
                                        <label for="editNomePastoral" class="form-label mb-1 block">Nome da Pastoral</label>
                                        <input type="text" class="px-2 form-input w-full border rounded-md h-12" id="editNomePastoral" name="nomePastoral" value="{{ $pastoral->nome }}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editDescricao" class="form-label mb-1 block">Descrição</label>
                                        <textarea class="px-2 form-input w-full border rounded-md h-24 resize-y" id="editDescricao" name="descricao">{{ $pastoral->descricao }}</textarea>
                                    </div>

                                    <div class="mb-4">
                                        @if ($pastoral->imagem)
                                        <label for="photo" class="form-label mb-1 block">Imagem Atual</label>
                                        <img src="{{ asset('storage/' . $pastoral->imagem) }}" class="block mb-2" style="max-width: 200px;" alt="Imagem Atual">
                                        <!-- Botão para excluir a imagem -->
                                        <button type="button" class="text-red-500 hover:text-red-700" onclick="handleDeleteImage({{ $pastoral->id }})">Excluir Imagem</button>
                                    @else
                                        <p>Nenhuma imagem disponível.</p>
                                        <label for="photo" class="form-label mb-1 block">Selecione uma Imagem</label>
                                        <input type="file" name="photo" id="photo" class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-black focus:border-black">
                                        <p class="text-sm mx-2">Formatos aceitos (JPG | JPEG| PNG)</p>
                                    @endif

                                    </div>
                                    <div class="text-center">
                                        <button type="button" class="btn bg-[#960316] text-white hover:bg-[#FA9DAA] hover:text-black border border-[#960316] rounded-xl px-4 py-2" onclick="showConfirmationModal()">Cancelar</button>
                                        <button type="submit" class="btn bg-[#036896] text-white hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl px-4 py-2">Salvar</button>
                                    </div>
                                </form>

                           </div>


                        </div>
                        @endif
                        @endforeach
                    </div>
                </div>
<!--Cadastrar nova pastoral -->
<div id="cardPastoral" class="my-4 hidden">
    <div class="bg-white rounded-2xl shadow-lg">
        <div class="bg-[#036896] rounded-t-2xl text-white px-4 py-5 flex justify-between items-center">
            <h3 class="text-center mb-0 text-2xl flex-grow">INFORMAÇÕES PASTORAL</h3>
            <button id="btnFecharCard" class="text-black hover:text-white">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </button>
        </div>
        <form action="{{ route('pastorais.store') }}" method="POST" enctype="multipart/form-data" class="p-4" id="formPastoral">
            @csrf
            <div class="mb-6">
                <label for="nomePastoral" class="form-label mb-1 block">Nome da Pastoral</label>
                <input type="text" class="px-2 form-input w-full border rounded-md h-12" id="nomePastoral" name="nomePastoral" required>
                <div id="error-message" class="text-red-500 text-sm" style="display: none">Por favor,
                    preencha o nome da pastoral.</div>
            </div>
            <div class="mb-6">
                <label for="descricao" class="form-label mb-1 block">Descrição</label>
                <textarea class="px-2 form-input w-full border rounded-md h-32 resize-none" id="descricao" name="descricao"></textarea>
            </div>
            <div class="mb-4">
                <label for="photo" class="form-label mb-1 block">Selecione uma Imagem</label>
                <input type="file" name="photo" id="photo" class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-black focus:border-black">
                <p class="text-sm mx-2">Formatos aceitos (JPG | JPEG| PNG)</p>
            </div>
            <div class="text-white px-4 py-3 text-center">
                <button type="button" class="btn w-3/12 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black border border-[#960316] rounded-xl" onclick="showConfirmationModal()">Cancelar</button>
                <button type="button" id="submitBtn" class="btn w-3/12 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
            </div>
        </form>
    </div>
</div>

                <!-- Pastorais Inativas-->
                <div class="my-3">
                    <h2 class="text-center text-2xl font-semibold mt-3 mb-9">Pastorais Inativas</h2>
                    @foreach ($pastorais as $pastoral)
                    @if (!$pastoral->ativo)
                    <div class="bg-white shadow-lg rounded-2xl mb-4 mx-5">
                        <div class="bg-gray-200 rounded-md py-3 px-4 flex justify-between items-center cursor-pointer border border-gray-400">
                            <h4 class="font-semibold text-xl py-3 px-1">{{ $pastoral->nome }}</h4>
                            <div class=" ">
                                <button type="button"  class="relative group btn btn-outline-primary me-2 px-5" onclick="toggleEditForm({{ $pastoral->id }})">
                                    <i class="bi bi-pencil text-gray-800 group-hover:text-blue-500 transform group-hover:scale-110 transition-transform duration-300"></i>
                                    <span class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-24 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                        Editar
                                    </span>
                                </button>
                                <form action="{{ route('pastorais.ativar', $pastoral->id) }}" method="POST" class="inline">
                                    @csrf
                                    @method('PUT')
                                    <button type="submit" class="relative group btn btn-outline-success pr-5 ">
                                        <i class="bi bi-check-circle text-gray-800 group-hover:text-green-500 transform group-hover:scale-110 transition-transform duration-300"></i>
                                        <span class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-24 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                            Ativar
                                        </span>
                                    </button>
                                </form>
                            </div>
                        </div>
                        <div id="editForm{{ $pastoral->id }}" class="hidden bg-white shadow-lg rounded-2xl p-4 mt-2">
                            <form action="{{ route('pastorais.update', $pastoral->id) }}" method="POST" enctype="multipart/form-data" id="formPastoral">
                                @csrf
                                @method('PUT')
                                <div class="mb-3">
                                    <label for="editNomePastoral" class="form-label mb-1 block">Nome da Pastoral</label>
                                    <input type="text" class="px-2 form-input w-full border rounded-md h-12" id="editNomePastoral" name="nomePastoral" value="{{ $pastoral->nome }}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editDescricao" class="form-label mb-1 block">Descrição</label>
                                    <textarea class="px-2 form-input w-full border rounded-md h-24 resize-y" id="editDescricao" name="descricao">{{ $pastoral->descricao }}</textarea>
                                </div>

                                <div class="mb-4">
                                    @if ($pastoral->imagem)
                                    <label for="photo" class="form-label mb-1 block">Imagem
                                        Atual</label>
                                    <img src="{{ asset('storage/' . $pastoral->imagem) }}" class="block mb-2" style="max-width: 200px;" alt="Imagem Atual">
                                    <form action="{{ route('pastorais.update', $pastoral->id) }}" method="POST" enctype="multipart/form-data">
                                        @csrf
                                        @method('PUT')
                                        <input type="hidden" name="delete_image" value="1">
                                        <button type="submit" class="text-red-500 hover:text-red-700">Excluir Imagem</button>
                                    </form>
                                    @else
                                    <p>Nenhuma imagem disponível.</p>
                                    <label for="photo" class="form-label mb-1 block">Selecione uma
                                        Imagem</label>
                                    <input type="file" name="photo" id="photo" class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-black focus:border-black">
                                    <p class="text-sm mx-2">Formatos aceitos (JPG | JPEG| PNG)</p>
                                    @endif
                                </div>
                                <div class="text-center">
                                    <button type="button" class="btn bg-[#960316] text-white hover:bg-[#FA9DAA] hover:text-black border border-[#960316] rounded-xl px-4 py-2" onclick="hideEditForm({{ $pastoral->id }})">Cancelar</button>
                                    <button type="submit" class="btn bg-[#036896] text-white hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl px-4 py-2">Salvar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    @endif
                    @endforeach
                </div>

                <!--  Modal Cancelar Alterações -->
                <div id="confirmationModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                    <div class="bg-white w-1/3 p-8 rounded-md">
                        <h3 class="text-[#960316] text-lg font-bold text-center mb-4">Cancelar Alterações?</h3>
                        <p class="mb-4 mt-2 text-center">Tem certeza de que deseja cancelar? As alterações não serão
                            salvas.</p>
                        <div class="flex justify-center">
                            <button id="btnCancelarFecharModal" class="px-4 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black text-white border border-[#036896] rounded-xl mr-2">Voltar</button>
                            <button id="btnCancelarCard" class="px-4 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black text-white border border-[#960316] rounded-xl">Confirmar</button>
                        </div>
                    </div>
                </div>

                <!--  Modal Excluir Pastoral -->
                <div id="excluirModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                    <div class="bg-white w-1/3 p-8 rounded-md">
                        <h3 class="text-[#960316] text-lg font-bold text-center mb-4">Inativar Pastoral?</h3>
                        <p class="mt-2 mb-4">Tem certeza de que deseja inativar? A pastoral não aparecerá mais na lista
                            de pastorais cadastradas.</p>
                        <div class="flex justify-center items-center align-center">
                            <button id="btnExcluirFecharModal" class="px-4 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black text-white border border-[#036896] rounded-xl mr-2">Voltar</button>
                            <form id="formExcluirPastoral" method="POST" action="{{ route('pastorais.inativar', ['id' => 0]) }}">
                                @csrf
                                <input type="hidden" id="excluirPastoralId" name="pastoral_id">
                                <button type="submit" class="mt-4 px-4 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black text-white border border-[#960316] rounded-xl">Confirmar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        function toggleEditForm(id) {
            const editForm = document.getElementById('editForm' + id);
            editForm.classList.toggle('hidden');
        }

        function hideEditForm(id) {
            const editForm = document.getElementById('editForm' + id);
            editForm.classList.add('hidden');
        }

        function showConfirmationModal() {
            const confirmationModal = document.getElementById('confirmationModal');
            confirmationModal.classList.remove('hidden');
        }

        function hideConfirmationModal() {
            const confirmationModal = document.getElementById('confirmationModal');
            confirmationModal.classList.add('hidden');
        }

        document.getElementById('btnCancelarFecharModal').addEventListener('click', hideConfirmationModal);
        document.getElementById('btnCancelarCard').addEventListener('click', hideConfirmationModal);

        document.getElementById('btnMostrarCard').addEventListener('click', function() {
            document.getElementById('cardPastoral').classList.remove('hidden');
        });

        document.getElementById('btnFecharCard').addEventListener('click', function() {
            showConfirmationModal();
        });

        document.getElementById('btnCancelarCard').addEventListener('click', function() {
            hideConfirmationModal();
            document.getElementById('cardPastoral').classList.add('hidden');
        });

        function showExcluirModal(id) {
            const excluirModal = document.getElementById('excluirModal');
            const excluirPastoralId = document.getElementById('excluirPastoralId');
            excluirPastoralId.value = id;
            excluirModal.classList.remove('hidden');
        }

        function hideExcluirModal() {
            const excluirModal = document.getElementById('excluirModal');
            excluirModal.classList.add('hidden');
        }

        document.getElementById('btnExcluirFecharModal').addEventListener('click', hideExcluirModal);

        document.getElementById('submitBtn').addEventListener('click', function(event) {
            var nomePastoral = document.getElementById('nomePastoral').value;
            var errorMessage = document.getElementById('error-message');

            if (nomePastoral.trim() === "") {
                errorMessage.style.display = 'block';
            } else {
                errorMessage.style.display = 'none';
                document.getElementById('formPastoral').submit();
            }
        });


        function handleDeleteImage(pastoralId) {
        if (confirm("Tem certeza de que deseja excluir esta imagem?")) {
            // Enviar uma solicitação AJAX para excluir a imagem
            fetch("{{ route('pastorais.deleteImage', $pastoral->id) }}", {
                method: 'POST',
                headers: {
                    'X-CSRF-TOKEN': '{{ csrf_token() }}',
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                },
                body: JSON.stringify({ pastoral_id: pastoralId })
            })
            .then(response => {
                if (response.ok) {
                    // Atualizar a página após a exclusão bem-sucedida
                    window.location.reload();
                } else {
                    throw new Error('Erro ao excluir a imagem.');
                }
            })
            .catch(error => {
                console.error('Erro:', error);
                alert('Erro ao excluir a imagem. Por favor, tente novamente.');
            });
        }
    }
    </script>
@endsection
