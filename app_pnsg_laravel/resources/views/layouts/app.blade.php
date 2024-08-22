<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.min.css"
        integrity="sha256-Qsx5lrStHZyR9REqhUF8iQt73X06c8LGIUPzpOhwRrI=" crossorigin="anonymous">
    <!-- Scripts -->
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>

<body class="">
    <div class="flex">
        <!-- Sidebar -->
        @include('layouts.sidebar')


        <div class=" flex-1">
            <!-- Navigation -->
            @include('layouts.navigation')

            <!-- Page Content -->
            <main>
                <div class=" mx-auto sm:px-6 lg:px-8">
                    @yield('content')
                </div>
            </main>
        </div>
    </div>
</body>

</html>
