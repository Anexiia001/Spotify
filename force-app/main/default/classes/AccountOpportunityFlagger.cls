//Codigo Apex
//Crea una clase Apex que consulte todas las Cuentas que tengan más de cinco Oportunidades relacionadas
// y actualiza un campo personalizado en esas Cuentas (por ejemplo, Has_Many_Opportunities__c = true). 
//Este ejercicio te permitirá practicar consultas SOQL con condiciones agregadas y 
//el uso correcto de DML en múltiples registros.

//Para este ejercicio investigue que puedo usar AggregateResult para poder usar GROUP BY y Having, sin el, el GROUP BY me marcaba error de sintaxis,
//Tambien investigue que no puedes hacer una query que extraiga mas de una cosa con AggregateResult, en este caso, los ID de Opportunities

//Comentaré cada parte para recordarme que hace cada apartado, eso me funciona mientras aprendo, jeje. 

public with sharing class AccountOpportunityFlagger {

    //Método público, estático, es decir, para llamarlo sin tener que crear un objeto de la clase/instancia. Void: no devuelve nada. 
    public static void flagAccountsWithManyOpps() {

        // Lista que regresa mediante un query los AccountId con más de 5 opportunities, se usa AggregateResult para poder usar GROUP BY y Having, sino, da error de sintaxis al querer usarlos. 
        List<AggregateResult> groupedOpps = [
            SELECT AccountId, COUNT(Id) total
            FROM Opportunity
            WHERE AccountId != null
            GROUP BY AccountId
            HAVING COUNT(Id) > 5
        ];

        // Convertir a Set para poder usarlo en la consulta de las cuentas y no repetir los Ids.
        Set<Id> accountIds = new Set<Id>();
        for (AggregateResult ar : groupedOpps) {
            accountIds.add((Id) ar.get('AccountId'));
        }

        // Sí no hay cuentas, no hace nada. 
        if (accountIds.isEmpty()) {
            return;
        }

        // Sí hay, hace la consulta de las cuentas con los Ids que se obtuvieron en el paso 1.
        List<Account> accountsToUpdate = [
            SELECT Id, Has_Many_Opportunities__c
            FROM Account
            WHERE Id IN :accountIds
        ];

        // 3. Actualizar el campo Has_Many_Opportunities__c a true para las cuentas encontradas. 
        for (Account acc : accountsToUpdate) {
            acc.Has_Many_Opportunities__c = true;
        }

        // 4. Actualizamos los cambios en las cuentas.
        update accountsToUpdate;
    }
}
