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
            <form id="formDizimo" action="{{ route('dizimo.salvar') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="mb-4">
                    <div class="mb-6">
                        <label for="chavePix" class="form-label mb-2 text-gray-700 font-bold block">Chave PIX</label>
                        <input type="text"
                            class="px-2 shadow appearance-none w-full border rounded-md h-12 leading-tight focus:outline-none focus:shadow-outline"
                            id="chavePix" name="chavePix" value="{{ $dizimo->chavePix ?? '' }}" maxlength="255" required>
                    </div>

                    <div class="mb-6">
                        <label for="QRCode" class="form-label mb-2 text-gray-700 font-bold block">QR Code:</label>
                        <div class="flex items-center">
                            <label for="QRCode"
                                class="cursor-pointer bg-[#036896] hover:bg-[#9DDEFB] hover:text-black text-white font-semibold py-2 px-4 rounded-md border border-[#036896]">
                                Selecione uma imagem
                            </label>
                            <input type="file" id="QRCode" name="QRCode" accept="image/*" class="hidden">
                            <span id="fileNameQRCode" class="ml-4 text-gray-700">Nenhum arquivo selecionado</span>
                        </div>
                        @if (isset($dizimo) && $dizimo->QRCode)
                            <div class="mt-4 relative" id="imagePreviewContainerQRCode">
                                <img src="{{ asset('storage/' . $dizimo->QRCode) }}" alt="QR Code"
                                    class="w-auto max-h-72 object-cover rounded-md mx-auto" id="previewImageQRCode">

                                <button type="button" id="removeImageBtnQRCode"
                                    class="absolute top-0 right-0 mt-2 mr-2 px-3 py-2 bg-red-500 text-white rounded-lg p-1">
                                    Remover
                                </button>
                                <input type="hidden" name="removeQRCode" id="removeQRCodeField" value="0">
                            </div>
                        @endif
                    </div>

                    <div class="flex justify-center mt-12">
                        <button type="submit" id="submitBtnDizimo"
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
            <form id="formDoacao" action="{{ route('doacao.salvar') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="mb-4">
                    <div class="mb-6">
                        <label for="chavePixDoacao" class="form-label mb-2 text-gray-700 font-bold block">Chave PIX</label>
                        <input type="text"
                            class="px-2 shadow appearance-none w-full border rounded-md h-12 leading-tight focus:outline-none focus:shadow-outline"
                            id="chavePixDoacao" name="chavePix" value="{{ $doacao->chavePix ?? '' }}" maxlength="255"
                            required>
                    </div>
                    <div class="mb-6">
                        <label for="imagemDoacao" class="form-label mb-2 text-gray-700 font-bold block">QR Code:</label>
                        <div class="flex items-center">
                            <label for="imagemDoacao"
                                class="cursor-pointer bg-[#036896] hover:bg-[#9DDEFB] hover:text-black text-white font-semibold py-2 px-4 rounded-md border border-[#036896]">
                                Selecione uma imagem
                            </label>
                            <input type="file" id="imagemDoacao" name="QRCode" accept="image/*" class="hidden">
                            <span id="fileNameDoacao" class="ml-4 text-gray-700">Nenhum arquivo selecionado</span>
                        </div>
                        @if (isset($doacao) && $doacao->QRCode)
                            <div class="mt-4 relative" id="imagePreviewContainerDoacao">
                                <img src="{{ asset('storage/' . $doacao->QRCode) }}" alt="QR Code"
                                    class="w-auto max-h-72 object-cover rounded-md mx-auto" id="previewImageDoacao">

                                <button type="button" id="removeImageBtnDoacao"
                                    class="absolute top-0 right-0 mt-2 mr-2 px-3 py-2 bg-red-500 text-white rounded-lg p-1">
                                    Remover
                                </button>
                                <input type="hidden" name="removeQRCode" id="removeQRCodeFieldDoacao" value="0">
                            </div>
                        @endif
                    </div>
                    <div class="flex justify-center mt-12">
                        <button type="submit" id="submitBtnDoacao"
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

            function handleImageUpload(inputId, previewId, containerId, fileNameId, removeBtnId, removeFieldId) {
                const fileInput = document.getElementById(inputId);
                const previewImage = document.getElementById(previewId);
                const previewContainer = document.getElementById(containerId);
                const fileName = document.getElementById(fileNameId);
                const removeBtn = document.getElementById(removeBtnId);
                const removeField = removeFieldId ? document.getElementById(removeFieldId) : null;

                fileInput.addEventListener('change', function() {
                    const file = fileInput.files[0];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function(event) {
                            previewImage.src = event.target.result;
                            previewContainer.classList.remove('hidden');
                            fileName.textContent = file.name;
                            if (removeField) {
                                removeField.value = '0'; // Reset remove field when new file is uploaded
                            }
                        };
                        reader.readAsDataURL(file);
                    } else {
                        previewContainer.classList.add('hidden');
                        fileName.textContent = 'Nenhum arquivo selecionado';
                    }
                });

                removeBtn.addEventListener('click', function() {
                    previewImage.src = '';
                    previewContainer.classList.add('hidden');
                    fileInput.value = ''; // Clear the file input
                    fileName.textContent = 'Nenhum arquivo selecionado';

                    if (removeField) {
                        removeField.value = '1'; // Mark the image for removal
                    }
                });
            }

            // Chamada da função para o QR Code do Dízimo
            handleImageUpload(
                'QRCode',
                'previewImageQRCode',
                'imagePreviewContainerQRCode',
                'fileNameQRCode',
                'removeImageBtnQRCode',
                'removeQRCodeField'
            );


            document.getElementById('submitBtnDizimo').addEventListener('click', function() {
                document.getElementById('formDizimo').submit();
            });

            document.getElementById('submitBtnDoacao').addEventListener('click', function() {
                document.getElementById('formDoacao').submit();
            });
        });
    </script>
@endsection
