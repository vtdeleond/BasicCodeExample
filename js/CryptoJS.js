(function() {
    //https://code.google.com/p/crypto-js/
    function getMD5() {
        //var tmpvt = $(document).find('form').html();//document.documentElement.innerHTML;
        var tmpvt = new Array();
        var tpHash;
        //$(document).find('input').each(function(){
        $(document).find('input:not(#idPROXIMO, #__isProcessing, #idXSEEDMSG)').each(function(){
            tmpvt.push($(this).val());
        });
        tmpvt.sort();
        tpHash = CryptoJS.MD5(tmpvt.join());
        return tpHash;
    }

    function tpAsignaEventos() {
        $('#prueba').on('click', function() {
            getMD5();
        });
        //
        $('#idBUTTON1').on('click', function() {
            tpAsignaEventosOnclickButton();
        }).prop({'onclick' : '', 'onkeydown' : ''});
        //
        function tpAsignaEventosOnclickButton () {
            var tpAccion = $('#idACCION').val();
            if (tpAccion == 'CON') {
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