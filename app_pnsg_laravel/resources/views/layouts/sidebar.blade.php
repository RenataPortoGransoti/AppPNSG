<aside class="bg-gray-800 text-white w-64 min-h-screen d-none d-md-block">
    <!--begin::Sidebar Brand-->
    <div class="flex items-center justify-center py-4">
        <!--begin::Brand Link-->
        <a href="{{ url('/') }}" class="flex items-center">
            <!--begin::Brand Image-->
            <div>
                <x-application-logo class="" />
            </div>
            <!--end::Brand Image-->
            <!--begin::Brand Text-->
            <span class="text-lg font-light">Painel Admin PNSG</span>
            <!--end::Brand Text-->
        </a>
        <!--end::Brand Link-->
    </div>
    <!--end::Sidebar Brand-->
    <!--begin::Sidebar Wrapper-->
    <div class="px-4">
        <nav class="mt-4">
            <ul class="space-y-2">
                <li class="nav-item {{ Request::is('dashboard') ? 'bg-gray-600' : '' }}">
                    <a href="{{ url('/dashboard') }}" class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-700">
                        <i class="bi bi-clipboard-data"></i>
                        <span class="ml-3">Dashboard</span>
                    </a>
                </li>
                <li class="nav-item {{ Request::is('inicio') ? 'bg-gray-600' : '' }}">
                    <a href="{{ url('/inicio') }}" class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-700">
                        <i class="bi bi-house-door"></i>
                        <span class="ml-3">Início</span>
                    </a>
                </li>
                <li class="nav-item {{ Request::is('pastorais') ? 'bg-gray-600' : '' }}">
                    <a href="{{ url('/pastorais') }}" class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-700">
                        <i class="bi bi-people"></i>
                        <span class="ml-3">Pastorais</span>
                    </a>
                </li>
                <li class="nav-item {{ Request::is('eventos') ? 'bg-gray-600' : '' }}">
                    <a href="{{ url('/eventos') }}" class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-700">
                        <i class="bi bi-calendar-week"></i>
                        <span class="ml-3">Eventos</span>
                    </a>
                </li>
                <li class="nav-item {{ Request::is('contribua') ? 'bg-gray-600' : '' }}">
                    <a href="{{ url('/contribua') }}" class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-700">
                        <i class="bi bi-cash-coin"></i>
                        <span class="ml-3">Contribua</span>
                    </a>
                </li>
                <li class="nav-item {{ Request::is('informacoes') ? 'bg-gray-600' : '' }}">
                    <a href="{{ url('/informacoes') }}" class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-700">
                        <i class="bi bi-info-circle"></i>
                        <span class="ml-3">Informações</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
    <!--end::Sidebar Wrapper-->
</aside>
<!--end::Sidebar-->

<!-- Script para esconder/mostrar sidebar em dispositivos móveis -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const sidebarToggle = document.querySelector('#sidebarToggle');
        const sidebar = document.querySelector('.bg-gray-800');

        sidebarToggle.addEventListener('click', function () {
            sidebar.classList.toggle('hidden');
        });
    });
</script>
