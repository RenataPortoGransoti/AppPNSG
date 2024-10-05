<footer class="bg-gray-800 text-white py-6">
    <div class="container mx-auto px-4">
        <div class="flex flex-col md:flex-row md:justify-evenly">
            <div class="mb-4 md:mb-0">
                <h5 class="text-lg font-semibold">Paróquia Nossa Senhora das Graças - Londrina, PR</h5>
                <p class="text-sm">“Tudo quanto fizerdes, por palavra ou por obra, fazei-o em nome do Senhor Jesus, dando
                    por ele graças a Deus Pai”
                </p>
                <p>(Colossenses 3,17)</p>
            </div>
            <div class="mb-4 md:mb-0">
                <h5 class="text-lg font-semibold">Páginas</h5>
                <ul class="text-sm space-y-1">
                    <li><a href="{{ url('/inicio') }}" class="hover:underline">Início</a></li>
                    <li><a href="{{ url('/eventos') }}" class="hover:underline">Eventos</a></li>
                    <li><a href="{{ url('/pastorais') }}" class="hover:underline">Pastorais</a></li>
                    <li><a href="{{ url('/informacoes') }}" class="hover:underline">Informações</a></li>
                </ul>
            </div>
            <div>
                <h5 class="text-lg font-semibold">Siga-nos</h5>
                <div class="flex space-x-4">
                    <a href="https://www.facebook.com/pnsgracalondrina/" target="_blank"
                        class="text-gray-400 hover:text-white">
                        <i class="bi bi-facebook"></i>
                    </a>
                    <a href="https://www.instagram.com/pnsgracalondrina/" target="_blank"
                        class="text-gray-400 hover:text-white">
                        <i class="bi bi-instagram"></i>
                    </a>
                </div>
            </div>
        </div>
        <div class="mt-6 text-center border-t border-gray-700 pt-4">
            <p class="text-sm">&copy; {{ date('Y') }} Paróquia Nossa Senhora das Graças. Todos os direitos
                reservados.</p>
        </div>
    </div>
</footer>
