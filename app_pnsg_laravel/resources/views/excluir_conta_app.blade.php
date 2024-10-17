<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Excluir Conta</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100">
    <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
        <h1 class="text-3xl font-bold mb-4">Excluir Conta</h1>

        @if (session('status'))
            <div class="bg-green-200 text-green-800 p-4 rounded mb-4">
                {{ session('status') }}
            </div>
        @endif

        <form method="POST">
            @csrf
            <div class="mb-4">
                <label for="nome" class="block text-lg font-medium">Nome Completo</label>
                <input type="text" id="nome" name="nome" required
                    class="mt-1 block w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring focus:ring-blue-300">
            </div>

            <div class="mb-4">
                <label for="email" class="block text-lg font-medium">E-mail</label>
                <input type="email" id="email" name="email" required
                    class="mt-1 block w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring focus:ring-blue-300">
            </div>

            <div class="mb-4">
                <label for="cpf" class="block text-lg font-medium">CPF</label>
                <input type="text" id="cpf" name="cpf" required
                    class="mt-1 block w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring focus:ring-blue-300">
            </div>

            <button type="submit"
                class="w-full bg-[#036896] text-white py-2 rounded-md hover:bg-blue-700">Enviar</button>
        </form>
    </div>
</body>

</html>
