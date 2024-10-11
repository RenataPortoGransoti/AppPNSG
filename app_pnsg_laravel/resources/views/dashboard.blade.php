@extends('layouts.app')

<head>
    <title>Dashboard | Painel Admin</title>
</head>

@section('content')
    <div class="container mx-auto p-4">
        <div class="flex justify-between items-center mb-4">
            <a href="{{ route('register') }}"
                class="rounded-md px-6 py-4 bg-[#9DDEFB] text-black font-semibold hover:bg-[#036896] hover:text-white transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-[#036896] focus:ring-offset-2">
                Registrar novo(a) secretário(a)
            </a>
            <form method="GET" action="{{ route('dashboard') }}" class="flex items-center">
                <select name="tipo" class="border border-gray-300 rounded-md p-2 mr-2">
                    <option value="">Todos</option>
                    <option value="secretário(a)">Secretário</option>
                    <option value="paroquiano">Paroquiano</option>
                </select>
                <button type="submit"
                    class="rounded-md px-6 py-2 bg-[#9DDEFB] text-black font-semibold hover:bg-[#9DDEFB] hover:text-white transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-[#036896] focus:ring-offset-2">
                    Filtrar
                </button>
            </form>
        </div>

        <div class="overflow-x-auto mt-16">
            <table class="min-w-full bg-white border border-gray-200">
                <thead class="bg-[#036896] text-white">
                    <tr>
                        <th class="py-2 px-4 border-b">Nome</th>
                        <th class="py-2 px-4 border-b">CPF</th>
                        <th class="py-2 px-4 border-b">Celular</th>
                        <th class="py-2 px-4 border-b">Email</th>
                        <th class="py-2 px-4 border-b">Data de Nascimento</th>
                        <th class="py-2 px-4 border-b">Tipo</th>
                        <th class="py-2 px-4 border-b">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse ($users as $user)
                        <tr class="border-b hover:bg-[#9DDEFB] transition-colors">
                            <td class="py-2 px-4 text-center">{{ $user->nome }}</td>
                            <td class="py-2 px-4 text-center">{{ $user->cpf }}</td>
                            <td class="py-2 px-4 text-center">{{ $user->celular }}</td>
                            <td class="py-2 px-4 text-center">{{ $user->email }}</td>
                            <td class="py-2 px-4 text-center">
                                {{ \Carbon\Carbon::parse($user->dataNascimento)->format('d/m/Y') }}</td>
                            <td class="py-2 px-4 text-center">{{ $user->tipo }}</td>
                            <td class="py-2 px-4 text-center">
                                <a href="{{ route('edit-user', $user->id) }}"
                                    class="text-[#036896] font-bold hover:underline">Editar</a>

                                @if ($user->ativo)
                                    <form action="{{ route('inativar.secretario') }}" method="POST"
                                        style="display:inline;">
                                        @csrf
                                        <input type="hidden" name="user_id" value="{{ $user->id }}">
                                        <button type="submit"
                                            class="text-red-600 font-bold hover:underline ml-4">Inativar</button>
                                    </form>
                                @else
                                    <form action="{{ route('ativar.secretario', $user->id) }}" method="POST"
                                        style="display:inline;">
                                        @csrf
                                        @method('PUT')
                                        <button type="submit"
                                            class="text-green-600 font-bold hover:underline ml-4">Ativar</button>
                                    </form>
                                @endif
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
