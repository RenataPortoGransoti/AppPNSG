<x-guest-layout>
    <form method="POST" action="{{ route('editar.secretario', $user->id) }}">
        @csrf
        @method('PUT')

        <div>
            <x-input-label for="nome" :value="__('Nome*')" />
            <x-text-input id="nome" class="block mt-1 w-full" type="text" name="nome" :value="old('nome', $user->nome)" required
                autofocus autocomplete="nome" />
            <x-input-error :messages="$errors->get('nome')" class="mt-2" />
        </div>

        <div class="mt-4">
            <x-input-label for="cpf" :value="__('CPF*')" />
            <x-text-input id="cpf" class="block mt-1 w-full" type="text" name="cpf" :value="old('cpf', $user->cpf)"
                placeholder="000.000.000-00" required />
            <x-input-error :messages="$errors->get('cpf')" class="mt-2" />
        </div>

        <div class="mt-4">
            <x-input-label for="celular" :value="__('Celular*')" />
            <x-text-input id="celular" class="block mt-1 w-full" type="text" name="celular" :value="old('celular', $user->celular)"
                placeholder="(00) 00000-0000" required />
            <x-input-error :messages="$errors->get('celular')" class="mt-2" />
        </div>

        <div class="mt-4">
            <x-input-label for="email" :value="__('E-mail*')" />
            <x-text-input id="email" class="block mt-1 w-full" type="text" name="email" :value="old('email', $user->email)"
                required />
            <x-input-error :messages="$errors->get('email')" class="mt-2" />
        </div>

        <div class="mt-4">
            <x-input-label for="dataNascimento" :value="__('Data de Nascimento*')" />
            <x-text-input id="dataNascimento" class="block mt-1 w-full" type="text" name="dataNascimento"
                :value="old('dataNascimento', \Carbon\Carbon::parse($user->dataNascimento)->format('d/m/Y'))" placeholder="dd/mm/aaaa" required />
            <x-input-error :messages="$errors->get('dataNascimento')" class="mt-2" />
        </div>

        <div class="mt-4">
            <x-input-label for="tipo" :value="__('Tipo*')" />
            <select id="tipo" name="tipo" class="block mt-1 w-full" required>
                <option value="secretário(a)" {{ old('tipo', $user->tipo) == 'secretário(a)' ? 'selected' : '' }}>
                    Secretário(a)</option>
                <option value="paroquiano(a)" {{ old('tipo', $user->tipo) == 'paroquiano(a)' ? 'selected' : '' }}>
                    Paroquiano(a)</option>
            </select>
            <x-input-error :messages="$errors->get('tipo')" class="mt-2" />
        </div>

        <div class="flex items-center justify-center mt-8">
            <x-primary-button class="ms-4">
                {{ __('Atualizar') }}
            </x-primary-button>
        </div>
    </form>

    @if ($errors->any())
        <div class="alert alert-danger mt-4">
            <ul>
                @foreach ($errors->all() as $error)
                    <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <!-- Script de jQuery Mask Plugin -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
    <script>
        $(document).ready(function() {
            // Máscara para CPF
            $('#cpf').mask('000.000.000-00', {
                reverse: true
            });

            // Máscara para telefone celular
            $('#celular').mask('(00) 00000-0000');

            // Máscara para data de nascimento
            $('#dataNascimento').mask('00/00/0000');
        });
    </script>
</x-guest-layout>
