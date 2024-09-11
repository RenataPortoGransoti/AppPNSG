@extends('layouts.app')

<title>Dashboard | Painel Admin</title>
@section('content')

    <body>
        <div class="flex justify-center mt-6">
            <a href="{{ route('register') }}"
                class="rounded-md px-6 py-4 bg-[#036896] text-white font-semibold hover:bg-[#9DDEFB] hover:text-black transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-[#036896] focus:ring-offset-2">
                Registrar novo(a) secretário(a)
            </a>
        </div>
    </body>
@endsection
