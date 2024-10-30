@extends('layouts.app')

<head>
    <title>Dashboard | Painel Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>

@section('content')
    <div class="container mx-auto p-4">
        <!-- Seção de filtro e botão de registrar -->
        <div class="flex flex-wrap justify-between items-center mb-4 gap-4">
            <a href="{{ route('register') }}"
                class="rounded-md px-6 py-4 w-full sm:w-auto bg-[#9DDEFB] text-black font-semibold hover:bg-[#036896] hover:text-white transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-[#036896] focus:ring-offset-2 text-center">
                Registrar novo(a) secretário(a)
            </a>
            <form method="GET" action="{{ route('dashboard') }}" class="flex flex-wrap items-center gap-2">
                <select name="tipo" class="border border-gray-300 rounded-md py-2 px-6">
                    <option value="">Todos</option>
                    <option value="secretário(a)">Secretário</option>
                    <option value="paroquiano(a)">Paroquiano</option>
                </select>
                <button type="submit"
                    class="rounded-md px-6 py-2 bg-[#9DDEFB] text-black font-semibold hover:bg-[#036896] hover:text-white transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-[#036896] focus:ring-offset-2">
                    Filtrar
                </button>
            </form>
        </div>

        <div class="overflow-x-auto mt-8">
            <table class="min-w-full bg-white border border-gray-200">
                <thead class="bg-[#036896] text-white">
                    <tr>
                        <th class="py-2 px-4 border-b text-left">Nome</th>
                        <th class="py-2 px-4 border-b text-left">CPF</th>
                        <th class="py-2 px-4 border-b text-left">Celular</th>
                        <th class="py-2 px-4 border-b text-left">Email</th>
                        <th class="py-2 px-4 border-b text-left">Data de Nascimento</th>
                        <th class="py-2 px-4 border-b text-left">Tipo</th>
                        <th class="py-2 px-4 border-b text-left">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse ($users as $user)
                        <tr class="border-b hover:bg-[#9DDEFB] transition-colors">
                            <td class="py-2 px-4 text-left break-all">{{ $user->nome }}</td>
                            <td class="py-2 px-4 text-left break-all">{{ $user->cpf }}</td>
                            <td class="py-2 px-4 text-left break-all">{{ $user->celular }}</td>
                            <td class="py-2 px-4 text-left break-all">{{ $user->email }}</td>
                            <td class="py-2 px-4 text-left">
                                {{ \Carbon\Carbon::parse($user->dataNascimento)->format('d/m/Y') }}</td>
                            <td class="py-2 px-4 text-left">{{ $user->tipo }}</td>
                            <td class="py-2 px-2 text-center">
                                <div class="flex justify-center items-center space-x-4">
                                    <!-- Link para Editar -->
                                    <a href="{{ route('edit-user', $user->id) }}"
                                        class="text-[#036896] font-bold hover:underline flex items-center" title="Editar">
                                        <span class="hidden lg:inline">Editar</span>
                                        <i class="fa fa-pencil md:inline lg:hidden ml-1" aria-hidden="true"
                                            title="Editar"></i>
                                    </a>

                                    <!-- Formulário de Inativar/Ativar -->
                                    @if ($user->ativo)
                                        <form action="{{ route('inativar.secretario') }}" method="POST"
                                            class="flex items-center m-0 p-0 justify-center">
                                            @csrf
                                            <input type="hidden" name="user_id" value="{{ $user->id }}">
                                            <button type="submit"
                                                class="text-red-600 font-bold hover:underline flex items-center"
                                                title="Inativar">
                                                <span class="hidden lg:inline">Inativar</span>
                                                <i class="fa fa-trash md:inline lg:hidden ml-1" aria-hidden="true"
                                                    title="Inativar"></i>
                                            </button>
                                        </form>
                                    @else
                                        <form action="{{ route('ativar.secretario', $user->id) }}" method="POST"
                                            class="flex items-center m-0 p-0 justify-center">
                                            @csrf
                                            @method('PUT')
                                            <button type="submit"
                                                class="text-green-600 font-bold hover:underline flex items-center"
                                                title="Ativar">
                                                <span class="hidden lg:inline">Ativar</span>
                                                <i class="fa fa-check md:inline lg:hidden ml-1" aria-hidden="true"
                                                    title="Ativar"></i>
                                            </button>
                                        </form>
                                    @endif
                                </div>
                            </td>

                        </tr>
                    @empty
                        <tr>
                            <td colspan="7" class="py-2 px-4 border-b text-center">Nenhum usuário encontrado.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
@endsection
