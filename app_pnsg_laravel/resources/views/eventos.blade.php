@extends('layouts.app')
<title>Eventos | Painel Admin</title>
@section('content')
    <main class="app-main flex-1 p-5 overflow-y-auto">
        <div class="container mx-auto">
            <h1 class="text-center font-semibold text-4xl">EVENTOS</h1>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mt-8">
                <!--EVENTOS ATIVOS-->
                <div class="my-4">
                    <div class="bg-white shadow-lg rounded-2xl border border-[#036896]">
                        <div class="text-center text-white px-4 py-3">
                            <button id="btnMostrarCard"
                                class="btn px-4 py-3 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">
                                <span>CADASTRAR EVENTO</span>
                            </button>
                        </div>
                        <!-- DIV CARD EVENTO -->
                        @foreach ($eventos as $evento)
                            @if ($evento->ativo)
                                <div class="bg-white shadow-lg rounded-2xl mb-4 mx-5">
                                    <div
                                        class="bg-[#9DDEFB] rounded-t-md py-3 px-4 flex justify-between items-center cursor-pointer border border-[#036896]">
                                        <h4 class="font-semibold text-xl py-3 px-5">{{ $evento->nome_evento }}</h4>
                                        <div class="flex-1">
                                            <p class="text-sm">Data de Início:
                                                {{ \Carbon\Carbon::parse($evento->data_inicio)->format('d/m/Y H:i') }}</p>
                                            @if (!empty($evento->data_fim))
                                                <p class="text-sm">Data de Fim:
                                                    {{ \Carbon\Carbon::parse($evento->data_fim)->format('d/m/Y H:i') }}</p>
                                            @endif
                                            <p class="text-sm">Local: {{ $evento->local }}</p>
                                            @if (!empty($evento->descricao))
                                                <p class="text-sm">Descrição: {{ $evento->descricao }}</p>
                                            @endif
                                        </div>
                                        <div class="flex items-center space-x-2">
                                            <button type="button" class="relative group btn btn-outline-primary me-2 px-5"
                                                onclick="toggleEditForm({{ $evento->id }})">
                                                <i
                                                    class="bi bi-pencil text-gray-800 group-hover:text-blue-500 transform group-hover:scale-110 transition-transform duration-300"></i>
                                                <span
                                                    class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-24 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                                    Editar
                                                </span>
                                            </button>
                                            <button type="button" class="relative group btn btn-outline-danger pr-5"
                                                onclick="showExcluirModal({{ $evento->id }})">
                                                <i
                                                    class="bi bi-trash text-gray-800 group-hover:text-red-500 transform group-hover:scale-110 transition-transform duration-300"></i>
                                                <span
                                                    class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-24 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                                    Inativar
                                                </span>
                                            </button>
                                        </div>
                                    </div>
                                    <!-- Forms de edição do EVENTO -->
                                    <div id="editForm{{ $evento->id }}" class="my-4 hidden">
                                        <form action="{{ route('eventos.editarEvento', ['evento' => $evento->id]) }}"
                                            class="px-3" method="POST">
                                            @csrf
                                            @method('PUT')
                                            <div class="mb-4">
                                                <label for="editNomeEvento" class="block mb-1">Nome do Evento</label>
                                                <input type="text" class="form-input w-full border rounded-md h-12"
                                                    id="editNomeEvento" name="edit_nome_evento"
                                                    value="{{ $evento->nome_evento }}" required>
                                            </div>
                                            <div class="mb-4">
                                                <label for="editDataInicio" class="block mb-1">Data Início</label>
                                                <input type="datetime-local" id="editDataInicio"
                                                    class="form-input border rounded-md h-10" name="edit_data_inicio"
                                                    value="{{ \Carbon\Carbon::parse($evento->data_inicio)->format('Y-m-d\TH:i') }}"
                                                    required>
                                            </div>

                                            <div class="mb-4">
                                                <label for="editDataFim" class="block mb-1">Data Fim</label>
                                                <input type="datetime-local" id="editDataFim"
                                                    class="form-input border rounded-md h-10" name="edit_data_fim"
                                                    value="{{ \Carbon\Carbon::parse($evento->data_fim)->format('Y-m-d\TH:i') }}">
                                            </div>

                                            <div class="mb-4">
                                                <label for="editLocal" class="block mb-1">Local</label>
                                                <input type="text" class="form-input w-full border rounded-md h-10"
                                                    id="editLocal" name="edit_local" value="{{ $evento->local }}" required>
                                            </div>
                                            <div class="mb-4">
                                                <label for="editDescricao" class="block mb-1">Descrição</label>
                                                <textarea class="form-textarea w-full border rounded-md px-2" id="editDescricao" name="edit_descricao">{{ $evento->descricao }}</textarea>
                                            </div>
                                            <div class="text-white px-4 py-3 text-center">
                                                <button type="button"
                                                    class="btn w-3/12 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black border border-[#960316] rounded-xl"
                                                    onclick="hideEditForm({{ $evento->id }})">Cancelar</button>
                                                <button type="submit"
                                                    class="btn w-3/12 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            @endif
                        @endforeach
                    </div>
                </div>

                <!-- Cadastrar novo evento -->
                <div id="cardEvento" class="my-4 hidden">
                    <div class="bg-white rounded-2xl shadow-lg">
                        <div class="bg-[#036896] rounded-t-2xl text-white px-4 py-5 flex justify-between items-center">
                            <h3 class="text-center mb-0 text-2xl flex-grow">INFORMAÇÕES EVENTO</h3>
                            <button id="btnFecharCard" class="text-black hover:text-white">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M6 18L18 6M6 6l12 12" />
                                </svg>
                            </button>
                        </div>
                        <form action="{{ route('eventos.store') }}" method="POST" enctype="multipart/form-data"
                            class="p-4" id="formEvento">
                            @csrf
                            <div class="mb-4">
                                <label for="nomeEvento" class="block mb-1">Nome do Evento</label>
                                <input type="text" class="form-input w-full border rounded-md h-12" id="nomeEvento"
                                    name="nome_evento" required>
                                <div id="error-message-nomeEvento" class="text-red-500 text-sm" style="display: none">Por
                                    favor, preencha o nome do evento.</div>
                            </div>
                            <div class="mb-4">
                                <label for="dataInicio" class="block mb-1">Data e Hora de Início</label>
                                <input type="datetime-local" id="dataInicio" class="form-input border rounded-md h-10"
                                    name="data_inicio" required>
                                <div id="error-message-dataInicio" class="text-red-500 text-sm" style="display: none">Por
                                    favor, preencha a data e hora de início.</div>
                            </div>
                            <div class="mb-4">
                                <label for="dataFim" class="block mb-1">Data e Hora de Fim</label>
                                <input type="datetime-local" id="dataFim" class="form-input border rounded-md h-10"
                                    name="data_fim">
                            </div>
                            <div class="mb-4">
                                <label for="local" class="block mb-1">Local</label>
                                <input type="text" class="form-input w-full border rounded-md h-10" id="local"
                                    name="local" required>
                                <div id="error-message-local" class="text-red-500 text-sm" style="display: none">Por
                                    favor, preencha o local do evento.</div>
                            </div>
                            <div class="mb-4">
                                <label for="descricao" class="block mb-1">Descrição</label>
                                <textarea class="form-textarea w-full border rounded-md" id="descricao" name="descricao"></textarea>
                            </div>
                            <div class="text-white px-4 py-3 text-center">
                                <button type="button"
                                    class="btn w-3/12 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black border border-[#960316] rounded-xl"
                                    onclick="showConfirmationModal()">Cancelar</button>
                                <button type="submit"
                                    class="btn w-3/12 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Eventos Inativos -->
                <div class="my-4">
                    <h2 class="text-center text-2xl font-semibold mb-3">Eventos Inativos</h2>
                    @foreach ($eventos as $evento)
                        @if (!$evento->ativo)
                            <div class="bg-white shadow-lg rounded-2xl mb-4  mx-5">
                                <div
                                    class="bg-gray-200 rounded-md py-3 px-4 flex justify-between items-center cursor-pointer border border-gray-400">
                                    <h4 class="font-semibold text-xl py-3 px-1">{{ $evento->nome_evento }}</h4>
                                    <div class="flex items-center space-x-2">
                                        <form action="{{ route('eventos.ativar', $evento->id) }}" method="POST"
                                            class="mb-0">
                                            @csrf
                                            @method('PUT')
                                            <button type="submit" class="relative group btn btn-outline-success pr-5 ">
                                                <i
                                                    class="bi bi-check-circle text-gray-800 group-hover:text-green-500 transform group-hover:scale-110 transition-transform duration-300"></i>
                                                <span
                                                    class="absolute bottom-full left-1/2 transform -translate-x-1/2  w-24 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                                    Ativar
                                                </span>
                                            </button>
                                            <button type="button" class="relative group btn btn-outline-danger pr-5"
                                                onclick="confirmSoftDelete({{ $evento->id }})">
                                                <i
                                                    class="bi bi-trash text-gray-800 group-hover:text-red-500 transform group-hover:scale-110 transition-transform duration-300"></i>
                                                <span
                                                    class="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-24 text-center text-sm rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none">
                                                    Excluir
                                                </span>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        @endif
                    @endforeach
                </div>

                <!--  Modal Cancelar Alterações -->
                <div id="confirmationModal"
                    class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                    <div class="bg-white w-1/3 p-8 rounded-md">
                        <h3 class="text-[#960316] text-lg font-bold text-center mb-4">Cancelar Alterações?</h3>
                        <p class="mb-4 mt-2 text-center">Tem certeza de que deseja cancelar? As alterações não serão
                            salvas.</p>
                        <div class="flex justify-center">
                            <button id="btnCancelarFecharModal"
                                class="px-4 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black text-white border border-[#036896] rounded-xl mr-2">Voltar</button>
                            <button id="btnCancelarCard"
                                class="px-4 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black text-white border border-[#960316] rounded-xl">Confirmar</button>
                        </div>
                    </div>
                </div>

                <!--  Modal Inativar Evento -->
                <div id="excluirModal"
                    class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                    <div class="bg-white w-1/3 p-8 rounded-md">
                        <h3 class="text-[#960316] text-lg font-bold text-center mb-4">Inativar Evento?</h3>
                        <p class="mt-2 mb-4">Tem certeza de que deseja inativar? O evento não aparecerá mais na lista
                            de eventos ativos.</p>
                        <div class="flex justify-center items-center align-center">
                            <button id="btnExcluirFecharModal"
                                class="px-4 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black text-white border border-[#036896] rounded-xl mr-2">Voltar</button>
                            <form id="formExcluirEvento" method="POST"
                                action="{{ route('eventos.inativar', ['id' => 0]) }}">
                                @csrf
                                <input type="hidden" id="excluirEventoId" name="evento_id">
                                <button type="submit"
                                    class="mt-4 px-4 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black text-white border border-[#960316] rounded-xl">Confirmar</button>
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
            document.getElementById('cardEvento').classList.remove('hidden');
        });

        document.getElementById('btnFecharCard').addEventListener('click', function() {
            hideConfirmationModal();
            document.getElementById('cardEvento').classList.add('hidden');
        });

        document.getElementById('btnCancelarCard').addEventListener('click', function() {
            hideConfirmationModal();
            document.getElementById('cardEvento').classList.add('hidden');
        });

        function showExcluirModal(id) {
            const excluirModal = document.getElementById('excluirModal');
            const excluirEventoId = document.getElementById('excluirEventoId');
            excluirEventoId.value = id;
            excluirModal.classList.remove('hidden');
        }

        function hideExcluirModal() {
            const excluirModal = document.getElementById('excluirModal');
            excluirModal.classList.add('hidden');
        }

        document.getElementById('btnExcluirFecharModal').addEventListener('click', hideExcluirModal);

        document.getElementById('submitBtn').addEventListener('click', function(event) {
            event.preventDefault();
            var nomeEvento = document.getElementById('nomeEvento').value;
            var errorMessage = document.getElementById('error-message-nomeEvento');

            if (nomeEvento.trim() === "") {
                errorMessage.style.display = 'block';
            } else {
                errorMessage.style.display = 'none';
                document.getElementById('formEvento').submit();
            }
        });

        function confirmSoftDelete(eventoId) {
            if (confirm('Tem certeza de que deseja excluir o evento? O evento não irá mais aparecer no sistema!')) {
                fetch(`/eventos/${eventoId}/soft-delete`, {
                        method: 'DELETE',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-TOKEN': '{{ csrf_token() }}'
                        }
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Ocorreu um erro ao excluir o evento.');
                        }
                        return response.json();
                    })
                    .then(data => {
                        alert(data.message);
                        window.location.reload();
                    })
                    .catch(error => {
                        alert(error.message);
                    });

            }
        }
    </script>
@endsection
