(function() {
    //https://code.google.com/p/crypto-js/
    //SourceTree
    function getMD5() {
        //
        var tmpvt = new Array();
        var tpHash;
        //
        $(document).find('input:not(#idPROXIMO, #__isProcessing, #idXSEEDMSG)').each(function(){
            tmpvt.push($(this).val());
        });
        tmpvt.sort();
        tpHash = CryptoJS.MD5(tmpvt.join());
        return tpHash;
    }

    function tpAsignaEventos() {
        $('#test').on('click', function() {
            getMD5();
        });
        //
        $('#idBUTTON').on('click', function() {
            tpAsignaEventosOnclickButton();
        }).prop({'onclick' : '', 'onkeydown' : ''});
        //
        function tpAsignaEventosOnclickButton () {
            var tpAccion = $('#idACCION').val();
            if (tpAccion == 'CON_') {
                var tpHashCON = getMD5();
                if (tpHashCON.words.join() != tmpvtd2.words.join()) {
                    if (!confirm('Hubo cambios en la trasacción, perdera los cambios. ¿Proceder? ')) {
                        return false;
                    }
                }
            }
            jXmit();
            flagEnter = 0;
        }
    }
});