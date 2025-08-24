trigger ArtistAlbumCountTrigger on Album__c (after insert, after delete) {
    //Set guarda los Ids de Artistas relacionados a los albumes.
    Set<Id> artistIds = new Set<Id>();

    //Recolecta los Ids de los Artistas relacionados a los albumes de la lista.
    if (Trigger.isInsert) {
        for (Album__c a : Trigger.new) {
            if (a.ArtistId__c != null) {
                artistIds.add(a.ArtistId__c);
            }
        }
    } else if (Trigger.isDelete) {
        for (Album__c a : Trigger.old) {
            if (a.ArtistId__c != null) {
                artistIds.add(a.ArtistId__c);
            }
        }
    }

    //Consultar la nueva cantidad de albumes por artista
    if (!artistIds.isEmpty()) {
        Map<Id, Integer> albumCounts = new Map<Id, Integer>();
        List<AggregateResult> results = [
            SELECT ArtistId__c Artist, COUNT(Id) total
            FROM Album__c
            WHERE ArtistId__c IN :artistIds
            GROUP BY ArtistId__c
        ];

        for (AggregateResult res : results) {
            albumCounts.put((Id)res.get('Artist'), (Integer)res.get('total'));
        }

        List<Artist__c> artistsToUpdate = new List<Artist__c>();

        for (Id artistId : artistIds) {
            Integer count = albumCounts.containsKey(artistId) ? albumCounts.get(artistId) : 0;
            artistsToUpdate.add(new Artist__c(Id = artistId, Total_Albums__c = count));
        }

        update artistsToUpdate;
    }
}

/*
Metodos:
-add: sirve para agregar elementos a un mapa, set y list
-containsKey: sirve para saber si un mapa tiene un elemento dentro
-get: sirve para obtener un elemento de un mapa
-put: sirve para agregar un elemento a un mapa
*/