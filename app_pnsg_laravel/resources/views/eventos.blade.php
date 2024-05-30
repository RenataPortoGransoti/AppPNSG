@extends('layouts.app')
<title>Eventos | Painel Admin</title>
@section('content')
<main class="app-main flex-1 p-5 overflow-y-auto">
        <div class="container mx-auto">
            <h1 class="text-center font-semibold text-4xl">EVENTOS</h1>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mt-8">

                <!--CARD EVENTOS ATIVOS-->
                <div class="my-4">
                    <div class="bg-white shadow-lg rounded-2xl border border-[#036896]">
                        <div class="text-center text-white px-4 py-3">
                            <button id="btnMostrarCard" class="btn px-4 py-3 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">
                                <span>CADASTRAR EVENTO</span>
                            </button>
                        </div>
                        <div class="bg-[#9DDEFB] rounded-md py-3 px-4 flex justify-between items-center cursor-pointer border border-[#036896]">
                            <h4 class="font-semibold text-xl py-3 px-1">Nome do Evento</h4>
                            <div class="flex items-center">
                                <button type="button" class="btn btn-outline-primary me-2 px-5">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <button type="button" class="btn btn-outline-danger pr-5">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Cadastrar novo evento-->
                <div id="cardPastoral" class="my-4 ">
                    <div class="bg-white rounded-2xl shadow-lg">
                        <div class="bg-[#036896] rounded-t-2xl text-white px-4 py-5 flex justify-between items-center">
                            <h3 class="text-center mb-0 text-2xl flex-grow">INFORMAÇÕES EVENTOS</h3>
                            <button id="btnFecharCard" class="text-black hover:text-white">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                </svg>
                            </button>
                        </div>


                        <form class="p-4" novalidate>
                            <div class="mb-4">
                                <label for="nomeEvento" class="block mb-1">Nome do Evento</label>
                                <input type="text" class="px-2 form-input w-full border rounded-md h-12" id="nomeEvento" name="nomeEvento" required>
                                <div id="error-message-nomeEvento" class="text-red-500 text-sm" style="display: none">Por favor,
                                    preencha o nome do evento.</div>
                            </div>
                            <div class="mb-4">
                                <label for="dataInicio" class="block mb-1">Data Início</label>
                                <input type="date" id="dataInicio" class="form-input  border rounded-md h-10 ">
                                <input type="time" class="form-input border rounded-md h-10 ">
                                <div id="error-message-dataInicio" class="text-red-500 text-sm" style="display: none">Por favor,
                                    preencha o nome do evento.</div>                            </div>
                            <div class="mb-4">
                                <label for="dataFim" class="block mb-1">Data Fim</label>
                                <input type="date" id="dataFim" class="form-input  border rounded-md h-10 ">
                                <input type="time" class="form-input  border rounded-md h-10 ">
                            </div>
                            <div class="mb-4">
                                <label for="local" class="block mb-1">Local</label>
                                <input type="text" class="px-2 form-input w-full border rounded-md h-10" id="localEvento" name="localEvento" required>
                                <div id="error-message-local" class="text-red-500 text-sm" style="display: none">Por favor,
                                    preencha o nome do evento.</div>                               </div>
                            <div class="mb-4">
                                <label for="descricao" class="block mb-1">Descrição</label>
                                <input type="text" class="px-2 form-input w-full border rounded-md h-10" id="descricaoEvento" name="descricaoEvento">
                            </div>
                            <div class="text-white px-4 py-3 text-center">
                                <button type="button" class="btn w-3/12 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black border border-[#960316] rounded-xl" onclick="showConfirmationModal()">Cancelar</button>
                                <button type="button" id="submitBtn" class="btn w-3/12 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </main>
@endsection
