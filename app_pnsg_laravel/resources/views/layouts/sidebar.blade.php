<aside class="bg-gray-800 text-white w-64 min-h-screen"> <!--begin::Sidebar Brand-->
    <div class="flex items-center justify-center py-4">
      <!--begin::Brand Link-->
      <a href="{{ url('/') }}" class="flex items-center">
        <!--begin::Brand Image-->
        <div>
            <x-application-logo class="" />

        </div>
        <!--end::Brand Image-->
        <!--begin::Brand Text-->
        <span class=" text-lg font-light">Painel Admin PNSG</span>
        <!--end::Brand Text-->
      </a>
      <!--end::Brand Link-->
    </div>
    <!--end::Sidebar Brand-->
    <!--begin::Sidebar Wrapper-->
    <div class="px-4">
      <nav class="mt-4">
        <!--begin::Sidebar Menu-->
        <ul class="space-y-2">
          <li class="nav-item">
            <a href="{{ url('/dashboard') }}" class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-700">
              <i class="bi bi-clipboard-data"></i>
              <span class="ml-3">Dashboard</span>
            </a>
          </li>
          <li class="nav-item">
            <a href="{{ url('/inicio') }}" class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-700">
              <i class="bi bi-house-door"></i>
              <span class="ml-3">Início</span>
            </a>
          </li>
          <li class="nav-item">
            <a href="{{ url('/pastorais') }}" class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-700">
              <i class="bi bi-people"></i>
              <span class="ml-3">Pastorais</span>
            </a>
          </li>
          <li class="nav-item">
            <a href="{{ url('/eventos') }}" class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-700">
              <i class="bi bi-calendar-week"></i>
              <span class="ml-3">Eventos</span>
            </a>
          </li>
          <li class="nav-item">
            <a href="{{ url('/contribua') }}" class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-700">
              <i class="bi bi-cash-coin"></i>
              <span class="ml-3">Contribua</span>
            </a>
          </li>
          <li class="nav-item">
            <a href="{{ url('/informacoes') }}" class="flex items-center p-2 text-base font-normal rounded-lg hover:bg-gray-700">
              <i class="bi bi-info-circle"></i>
              <span class="ml-3">Informações</span>
            </a>
          </li>
        </ul>
        <!--end::Sidebar Menu-->
      </nav>
    </div>
    <!--end::Sidebar Wrapper-->
  </aside>
  <!--end::Sidebar-->
  <script>
    const SELECTOR_SIDEBAR_WRAPPER = ".sidebar-wrapper";
    const Default = {
      scrollbarTheme: "os-theme-light",
      scrollbarAutoHide: "leave",
      scrollbarClickScroll: true,
    };
    document.addEventListener("DOMContentLoaded", function () {
      const sidebarWrapper = document.querySelector(SELECTOR_SIDEBAR_WRAPPER);
      if (
        sidebarWrapper &&
        typeof OverlayScrollbarsGlobal?.OverlayScrollbars !== "undefined"
      ) {
        OverlayScrollbarsGlobal.OverlayScrollbars(sidebarWrapper, {
          scrollbars: {
            theme: Default.scrollbarTheme,
            autoHide: Default.scrollbarAutoHide,
            clickScroll: Default.scrollbarClickScroll,
          },
        });
      }
    });
    </script>
