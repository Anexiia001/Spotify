trigger ArtistSongCountTrigger on Song__c (before insert) {
    //Set guarda los Ids de Artistas relacionados a las canciones.
    Set<Id> artistIds = new Set<Id>();

    //Recolecta los Ids de los Artistas relacionados a los canciones de la lista.
    if (Trigger.isInsert) {
        for (Song__c s : Trigger.new) {
            if (s.ArtistId__c != null) {
                artistIds.add(s.ArtistId__c);
            }
        }
    } else if (Trigger.isDelete) {
        for (Song__c s : Trigger.old) {
            if (s.ArtistId__c != null) {
                artistIds.add(s.ArtistId__c);
            }
        }
    }

    //Consultar la nueva cantidad de canciones por artista
    if (!artistIds.isEmpty()) {
        Map<Id, Integer> songCounts = new Map<Id, Integer>();
        List<AggregateResult> results = [
            SELECT ArtistId__c Artist, COUNT(Id) total
            FROM Song__c
            WHERE ArtistId__c IN :artistIds
            GROUP BY ArtistId__c
        ];

        for (AggregateResult res : results) {
            songCounts.put((Id)res.get('Artist'), (Integer)res.get('total'));
        }

        List<Artist__c> artistsToUpdate = new List<Artist__c>();

        for (Id artistId : artistIds) {
            Integer count = songCounts.containsKey(artistId) ? songCounts.get(artistId) : 0;
            artistsToUpdate.add(new Artist__c(Id = artistId, Total_Songs__c = count));
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