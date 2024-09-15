<x-guest-layout>
    <form method="POST" action="{{ route('register') }}">
        @csrf

        <div>
            <x-input-label for="nome" :value="__('Nome*')" />
            <x-text-input id="nome" class="block mt-1 w-full" type="text" name="nome" :value="old('nome')" required
                autofocus autocomplete="nome" />
            <x-input-error :messages="$errors->get('nome')" class="mt-2" />
        </div>

        <div class="mt-4">
            <x-input-label for="cpf" :value="__('CPF*')" />
            <x-text-input id="cpf" class="block mt-1 w-full" type="text" name="cpf" :value="old('cpf')"
                required />
            <x-input-error :messages="$errors->get('cpf')" class="mt-2" />
        </div>

        <div class="mt-4">
            <x-input-label for="celular" :value="__('Celular*')" />
            <x-text-input id="celular" class="block mt-1 w-full" type="text" name="celular" :value="old('celular')"
                required />
            <x-input-error :messages="$errors->get('celular')" class="mt-2" />
        </div>

        <div class="mt-4">
            <x-input-label for="email" :value="__('E-mail*')" />
            <x-text-input id="email" class="block mt-1 w-full" type="text" name="email" :value="old('email')"
                required />
            <x-input-error :messages="$errors->get('email')" class="mt-2" />
        </div>

        <div class="mt-4">
            <x-input-label for="dataNascimento" :value="__('Data de Nascimento*')" />
            <x-text-input id="dataNascimento" class="block mt-1 w-full" type="text" name="dataNascimento"
                :value="old('dataNascimento')" required />
            <x-input-error :messages="$errors->get('dataNascimento')" class="mt-2" />
        </div>

        <div class="mt-4 relative">
            <x-input-label for="password" :value="__('Senha*')" />
            <x-text-input id="password" class="block mt-1 w-full" type="password" name="password" required />
            <i class="bx bx-lock-alt absolute right-3 top-10 cursor-pointer" id="togglePasswordIcon"
                onclick="togglePasswordVisibility('password', 'togglePasswordIcon')"></i>
            <x-input-error :messages="$errors->get('password')" class="mt-2" />
        </div>

        <div class="mt-4 relative">
            <x-input-label for="password_confirmation" :value="__('Confirmar Senha*')" />
            <x-text-input id="password_confirmation" class="block mt-1 w-full" type="password"
                name="password_confirmation" required />
            <i class="bx bx-lock-alt absolute right-3 top-10 cursor-pointer" id="togglePasswordConfirmIcon"
                onclick="togglePasswordVisibility('password_confirmation', 'togglePasswordConfirmIcon')"></i>
            <x-input-error :messages="$errors->get('password_confirmation')" class="mt-2" />
        </div>

        <div class="flex items-center justify-center mt-8">
            <x-primary-button class="ms-4">
                {{ __('Registrar') }}
            </x-primary-button>
        </div>
    </form>
    @if ($errors->any())
        <div class="alert alert-danger">
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

            // Alternar visibilidade da senha
            window.togglePasswordVisibility = function(inputId, iconId) {
                const passwordInput = document.getElementById(inputId);
                const passwordIcon = document.getElementById(iconId);
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);

                if (type === 'text') {
                    passwordIcon.classList.remove('bx-lock-alt');
                    passwordIcon.classList.add('bx-lock-open-alt');
                } else {
                    passwordIcon.classList.remove('bx-lock-open-alt');
                    passwordIcon.classList.add('bx-lock-alt');
                }
            };
        });
    </script>
</x-guest-layout>
