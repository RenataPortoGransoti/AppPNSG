@extends('layouts.app')

@section('content')
    <main class="app-main">
        <div class="container mx-auto mt-1 mb-5 pt-2">
            <div class="flex justify-center">
                <div class="w-full md:w-3/4 lg:w-1/2">
                    @foreach ($horarios as $horario)
                        <div class="mt-4">
                            <div class="bg-white shadow-md rounded-lg">
                                <div class="flex items-center justify-between bg-blue-900 text-white rounded-t-lg px-4 py-2 cursor-pointer"
                                    data-toggle="collapse" data-target="#{{ Str::slug($horario['titulo']) }}">
                                    <h3 class="text-center">{{ $horario['titulo'] }}</h3>
                                    <i class="bi bi-plus-lg"></i>
                                    <i class="bi bi-dash-lg hidden"></i>
                                </div>
                                <div id="{{ Str::slug($horario['titulo']) }}" class="collapse">
                                    @if ($horario['visivel'])
                                        @foreach ($horario['texto'] as $texto)
                                            <div class="py-2 px-4">
                                                <input type="text" value="{{ $texto }}" class="form-input">
                                            </div>
                                        @endforeach
                                    @endif
                                </div>
                            </div>
                        </div>
                    @endforeach
                </div>
            </div>
        </div>
    </main>
@endsection
