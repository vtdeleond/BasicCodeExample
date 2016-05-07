import java.util.*;

public class GenToken {
    //Contructor
    private  GenToken() {}
    /*
    * Token's generator
    * Parameter: 
    * *len: key lenght
    * *option: 1 numeric, 2 alpha, 3 Alphanumeric, 
    *     0 (default)= all combinations
    */
    public static String getTOKEN(int len, int option) {
        String numericKey = "0123456789";
        String alphaKey = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        String especialKey = "~` :.<='*}!+,;%](+&/{-_>?@^#[$";
        StringBuilder sbKey = new StringBuilder();
        Random rnd = new Random();
                
        switch (option) {
        case 1:
            sbKey.append(numericKey);
            break;
        case 2:
            sbKey.append(alphaKey);
            break;
        case 3:
            sbKey.append(numericKey);
            sbKey.append(alphaKey);
            break;
        default:
            sbKey.append(numericKey);
            sbKey.append(alphaKey);
            sbKey.append(especialKey);
            break;
        }
                
        StringBuilder sbToken = new StringBuilder(len);
        for( int i = 0; i < len; i++ ) {
            char  cTmp = sbKey.charAt( rnd.nextInt(sbKey.length()) );
            //
            // trim all
            // 
            while ((i == 0 || i == len) && cTmp == ' ') {
              cTmp = sbKey.charAt( rnd.nextInt(sbKey.length()) );
            }
            sbToken.append(cTmp);
        }
        return sbToken.toString();
    }
}
