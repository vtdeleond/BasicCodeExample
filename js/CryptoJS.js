(function() {
    ///
    //https://code.google.com/p/crypto-js/
    function getMD5() {
        //
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
});