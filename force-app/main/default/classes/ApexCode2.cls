//Codigo APEX
//La funcion de este codigo tiene como objetivo analizar el objeto Account, traer el campo Industry
//y contar cuantas veces se repite en una cuenta y si el campo Industry esta vacio, omitirlo.
public with sharing class ApexCode2 {

    public ApexCode2() {

        List<Account> cuentas = [
            SELECT Id, Industry
            FROM Account
        ];

        Map<String, Integer> conteoAccounts = new Map<String, Integer>();

        for (Account cuenta : cuentas) {
            if (cuenta.Industry == null) {
                continue;
            }
            if (conteoAccounts.containsKey(cuenta.Industry)) {
                conteoAccounts.put(cuenta.Industry, conteoAccounts.get(cuenta.Industry) + 1);
            }
            else {
                conteoAccounts.put(cuenta.Industry, 1);
            }
        }
    }
}

