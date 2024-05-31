<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Informações | Painel Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">
    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
            document.querySelectorAll('.toggle-icon').forEach(icon => {
                icon.addEventListener('click', () => {
                    const cardBody = icon.closest('.card').querySelector('.card-body');
                    if (cardBody.style.display === 'none' || cardBody.style.display === '') {
                        cardBody.style.display = 'block';
                        icon.classList.remove('bi-plus');
                        icon.classList.add('bi-dash');
                    } else {
                        cardBody.style.display = 'none';
                        icon.classList.remove('bi-dash');
                        icon.classList.add('bi-plus');
                    }
                });
            });
        });
    </script>
</head>
<body>
    @extends('layouts.app')

    @section('content')

    <div class="container mx-auto max-w-4xl">
        <h1 class="text-center font-semibold text-4xl">INFORMAÇÕES GERAIS</h1>
        <div class="container mx-auto mt-4 mb-8">
            <div class="flex justify-center">
                <div class="w-full md:w-2/3">
                    <div class="px-8 py-4 bg-white shadow rounded-lg">
                        <h1 class="mb-4 text-center text-xl">Editar Informações</h1>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="space-y-3">
                                <div>
                                    <label for="contato" class="block text-gray-700">Contato</label>
                                    <input type="text" id="contato" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                </div>
                                <div>
                                    <label for="instagram" class="block text-gray-700">Instagram</label>
                                    <input type="text" id="instagram" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                </div>
                            </div>
                            <div class="space-y-3">
                                <div>
                                    <label for="email" class="block text-gray-700">E-mail</label>
                                    <input type="email" id="email" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                </div>
                                <div>
                                    <label for="facebook" class="block text-gray-700">Facebook</label>
                                    <input type="text" id="facebook" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                </div>
                            </div>
                        </div>
                        <div class="my-5">
                            <div class="card bg-white shadow rounded-lg overflow-hidden">
                                <div class="card-header flex items-center justify-between bg-[#036896] text-white p-4">
                                    <h3 class="text-center w-full">Horários Secretaria Paroquial</h3>
                                    <i class="bi bi-dash toggle-icon cursor-pointer text-white text-2xl"></i>
                                </div>
                                <div class="card-body p-4">
                                    <div class="my-2">
                                        <input type="text" value="Segunda à Sexta: 8h às 12h e 14h às 18h" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                    </div>
                                    <hr>
                                    <div class="my-2">
                                        <input type="text" value="Sábado: 14h às 18h" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="my-5">
                            <div class="card bg-white shadow rounded-lg overflow-hidden">
                                <div class="card-header flex items-center justify-between bg-[#036896] text-white p-4">
                                    <h3 class="text-center w-full">Missas</h3>
                                    <i class="bi bi-dash toggle-icon cursor-pointer text-white text-2xl"></i>
                                </div>
                                <div class="card-body p-4">
                                    <div class="my-2">
                                        <input type="text" value="Sábado: 7h e 19h" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                    </div>
                                    <hr>
                                    <div class="my-2">
                                        <input type="text" value="Domingo: 8h, 10h e 19h" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                    </div>
                                    <hr>
                                    <div class="my-2">
                                        <input type="text" value="Segunda à Sexta: 18:30h" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="my-5">
                            <div class="card bg-white shadow rounded-lg overflow-hidden">
                                <div class="card-header flex items-center justify-between bg-[#036896] text-white p-4">
                                    <h3 class="text-center w-full">Confissões</h3>
                                    <i class="bi bi-dash toggle-icon cursor-pointer text-white text-2xl"></i>
                                </div>
                                <div class="card-body p-4">
                                    <div class="my-2">
                                        <input type="text" value="Terça e Quinta: 17:30h às 18:20h" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-white px-4 py-3 text-center">
                            <button type="button" class="btn w-3/12 py-2 bg-[#960316] hover:bg-[#FA9DAA] hover:text-black border border-[#960316] rounded-xl" onclick="showConfirmationModal()">Cancelar</button>
                            <button type="button" id="submitBtn" class="btn w-3/12 py-2 bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    @endsection
</body>
</html>
