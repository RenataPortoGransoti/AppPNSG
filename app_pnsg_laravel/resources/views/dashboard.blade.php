@extends('layouts.app')

@section('content')
    <div class="container mx-auto p-4">
        <div class="flex justify-between items-center mb-4">
            <a href="{{ route('register') }}"
                class="rounded-md px-6 py-4 bg-[#036896] text-white font-semibold hover:bg-[#9DDEFB] hover:text-black transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-[#036896] focus:ring-offset-2">
                Registrar novo(a) usuário(a)
            </a>

            <!-- Formulário de Filtro -->
            <form method="GET" action="{{ route('dashboard') }}" class="flex items-center">
                <select name="tipo" class="border border-gray-300 rounded-md p-2 mr-2">
                    <option value="">Todos</option>
                    <option value="secretario">Secretário</option>
                    <option value="admin">Admin</option>
                    <!-- Adicione outras opções conforme necessário -->
                </select>
                <button type="submit" class="bg-blue-500 text-white rounded-md px-4 py-2 hover:bg-blue-700">
                    Filtrar
                </button>
            </form>
        </div>

        <div class="overflow-x-auto">
            <table class="min-w-full bg-white border border-gray-200">
                <thead>
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
                        <tr>
                            <td class="py-2 px-4 border-b">{{ $user->nome }}</td>
                            <td class="py-2 px-4 border-b">{{ $user->cpf }}</td>
                            <td class="py-2 px-4 border-b">{{ $user->celular }}</td>
                            <td class="py-2 px-4 border-b">{{ $user->email }}</td>
                            <td class="py-2 px-4 border-b">
                                {{ \Carbon\Carbon::parse($user->dataNascimento)->format('d/m/Y') }}</td>
                            <td class="py-2 px-4 border-b">{{ $user->tipo }}</td>
                            <td class="py-2 px-4 border-b">
                                <a href="{{ route('edit-user', $user->id) }}"
                                    class="text-blue-500 hover:underline">Editar</a>
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
