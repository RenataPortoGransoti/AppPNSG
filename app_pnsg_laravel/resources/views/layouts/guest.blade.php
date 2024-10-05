<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>PNSG</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />

    <!-- Scripts -->
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">

</head>

<body class="font-sans text-gray-900 antialiased">
    <header>
        <nav class="absolute top-4 md:top-8 left-2 md:left-6">
            @auth
                <a href="{{ route('dashboard') }}"
                    class="rounded-full bg-[#036896] px-3 md:px-5 py-2 md:py-3 text-white transition hover:bg-[#9DDEFB] hover:text-black focus:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-[#9DDEFB]">
                    Voltar
                </a>
            @else
                <a href="{{ route('welcome') }}"
                    class="rounded-full bg-[#036896] px-3 md:px-5 py-2 md:py-3 text-white transition hover:bg-[#9DDEFB] hover:text-black focus:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-[#9DDEFB]">
                    Voltar
                </a>
            @endauth
        </nav>
    </header>
    <main>
        <div class="min-h-screen flex flex-col sm:flex-row items-center pt-6 bg-gray-200 justify-center">
            <!-- Logo (imagem) -->
            <div class="mb-4 sm:mb-0 sm:mr-6 flex justify-center">
                <a href="/" class="flex justify-center items-center">
                    <x-application-logo class="w-24 h-24 sm:w-16 sm:h-16 fill-current text-gray-500" />
                </a>
            </div>

            <!-- Formulário responsivo -->
            <div class="w-full max-w-xs sm:max-w-md px-6 py-4 bg-white shadow-lg overflow-hidden sm:rounded-lg">
                {{ $slot }}
            </div>
        </div>
    </main>

</body>

</html>
