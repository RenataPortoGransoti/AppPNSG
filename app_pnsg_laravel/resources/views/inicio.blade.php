@extends('layouts.app')
    <title>Início | Painel Admin</title>
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


    @section('content')

    <div class="container mx-auto ">
        <h1 class="text-center font-semibold text-4xl">INÍCIO</h1>
        <div class="container mx-auto mt-4 mb-8">
            <div class="flex justify-center">
                <div class="w-full md:w-2/3">
                    <div class="px-8 py-4 bg-white shadow rounded-lg">



                        <div class="my-5">
                            <div class="card bg-white shadow rounded-lg overflow-hidden">
                                <div class="card-header flex items-center justify-between bg-[#036896] text-white p-4">
                                    <h3 class="text-center w-full">Avisos Paroquiais</h3>
                                    <i class="bi bi-dash toggle-icon cursor-pointer text-white text-2xl"></i>
                                </div>
                                <div class="card-body p-4">
                                    <div class="my-2">
                                        <input type="text" value="Aviso 1" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
                                    </div>
                                    <hr>
                                    <div class="my-2">
                                        <input type="text" value="Aviso 2" class="form-control block w-full mt-1 border-gray-300 rounded-md shadow-sm">
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

