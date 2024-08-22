@extends('layouts.app')
<title>Contribua | Painel Admin</title>

@section('content')
    <div class="container mx-auto">
        <h1 class="text-center font-semibold text-4xl my-6">CONTRIBUA</h1>
        <div class="flex justify-center">
            <div id="gerenciarDizimo"
                class="bg-[#9DDEFB] rounded-md py-36 px-36 my-12 mx-10 flex justify-between items-center cursor-pointer border border-[#036896]">
                <h3 class="text-4xl">Dízimo</h3>
            </div>
            <div id="gerenciarDoacao"
                class="bg-[#9DDEFB] rounded-md py-36 px-36 my-12 mx-10 flex justify-between items-center cursor-pointer border border-[#036896]">
                <h3 class="text-4xl">Doação</h3>
            </div>
        </div>
    </div>

    <!-- Modal Gerenciar Dízimo -->
    <div id="dizimoModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50">
        <div class="bg-white rounded-lg w-1/2 p-6 relative">
            <button id="closeDizimoModal"
                class="absolute top-2 right-2 text-gray-600 hover:text-gray-900 text-xl font-semibold">&times;</button>
            <h2 class="text-3xl font-semibold mb-4 text-center py-6">Gerenciar Dízimo</h2>
            <form id="formDizimo">
                <div class="mb-4">
                    <div class="mb-6">
                        <label for="chavePix" class="form-label mb-2 text-gray-700 font-bold block">Chave PIX</label>
                        <input type="text"
                            class="px-2 shadow appearance-none w-full border rounded-md h-12 leading-tight focus:outline-none focus:shadow-outline"
                            id="chavePix" name="chavePix" maxlength="60" required>
                    </div>
                    <div class="mb-6">
                        <label for="imagemDizimo" class="form-label mb-2 text-gray-700 font-bold block">QR Code:</label>
                        <div class="flex items-center">
                            <label for="imagemDizimo"
                                class="cursor-pointer bg-[#036896] hover:bg-[#9DDEFB] hover:text-black text-white font-semibold py-2 px-4 rounded-md border border-[#036896]">
                                Selecione uma imagem
                            </label>
                            <input type="file" id="imagemDizimo" name="imagemDizimo" accept="image/*" class="hidden">
                            <span id="fileNameDizimo" class="ml-4 text-gray-700">Nenhum arquivo selecionado</span>
                        </div>
                        <div id="imagePreviewContainerDizimo" class="mt-4 hidden relative">
                            <img id="previewImageDizimo" class="w-auto max-h-72 object-cover rounded-md mx-auto"
                                src="" alt="Pré-visualização da imagem">
                            <button type="button" id="removeImageBtnDizimo"
                                class="absolute top-0 right-0 mt-2 mr-2 px-3 py-2 bg-red-500 text-white rounded-lg p-1">
                                Remover
                            </button>
                        </div>
                    </div>
                    <div class="flex justify-center mt-12">
                        <button type="button" id="submitBtnDizimo"
                            class="btn w-3/12 py-2 text-white bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal Gerenciar Doação -->
    <div id="doacaoModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden z-50">
        <div class="bg-white rounded-lg w-1/2 p-6 relative">
            <button id="closeDoacaoModal"
                class="absolute top-2 right-2 text-gray-600 hover:text-gray-900 text-xl font-semibold">&times;</button>
            <h2 class="text-3xl font-semibold mb-4 text-center py-6">Gerenciar Doação</h2>
            <form id="formDoacao">
                <div class="mb-4">
                    <div class="mb-6">
                        <label for="chavePixDoacao" class="form-label mb-2 text-gray-700 font-bold block">Chave PIX</label>
                        <input type="text"
                            class="px-2 shadow appearance-none w-full border rounded-md h-12 leading-tight focus:outline-none focus:shadow-outline"
                            id="chavePixDoacao" name="chavePixDoacao" maxlength="60" required>
                    </div>
                    <div class="mb-6">
                        <label for="imagemDoacao" class="form-label mb-2 text-gray-700 font-bold block">QR Code:</label>
                        <div class="flex items-center">
                            <label for="imagemDoacao"
                                class="cursor-pointer bg-[#036896] hover:bg-[#9DDEFB] hover:text-black text-white font-semibold py-2 px-4 rounded-md border border-[#036896]">
                                Selecione uma imagem
                            </label>
                            <input type="file" id="imagemDoacao" name="imagemDoacao" accept="image/*" class="hidden">
                            <span id="fileNameDoacao" class="ml-4 text-gray-700">Nenhum arquivo selecionado</span>
                        </div>
                        <div id="imagePreviewContainerDoacao" class="mt-4 hidden relative">
                            <img id="previewImageDoacao" class="w-auto max-h-72 object-cover rounded-md mx-auto"
                                src="" alt="Pré-visualização da imagem">
                            <button type="button" id="removeImageBtnDoacao"
                                class="absolute top-0 right-0 mt-2 mr-2 px-3 py-2 bg-red-500 text-white rounded-lg p-1">
                                Remover
                            </button>
                        </div>
                    </div>
                    <div class="flex justify-center mt-12">
                        <button type="button" id="submitBtnDoacao"
                            class="btn w-3/12 py-2 text-white bg-[#036896] hover:bg-[#9DDEFB] hover:text-black border border-[#036896] rounded-xl">Salvar</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            function closeAllModals() {
                document.getElementById('dizimoModal').classList.add('hidden');
                document.getElementById('doacaoModal').classList.add('hidden');
            }

            document.getElementById('gerenciarDizimo').addEventListener('click', function() {
                closeAllModals(); // Close other modals
                document.getElementById('dizimoModal').classList.remove('hidden');
            });

            document.getElementById('closeDizimoModal').addEventListener('click', function() {
                document.getElementById('dizimoModal').classList.add('hidden');
            });

            document.getElementById('gerenciarDoacao').addEventListener('click', function() {
                closeAllModals(); // Close other modals
                document.getElementById('doacaoModal').classList.remove('hidden');
            });

            document.getElementById('closeDoacaoModal').addEventListener('click', function() {
                document.getElementById('doacaoModal').classList.add('hidden');
            });

            document.addEventListener('click', function(event) {
                if (event.target.id === 'dizimoModal' || event.target.id === 'doacaoModal') {
                    closeAllModals();
                }
            });
        });
    </script>
@endsection
