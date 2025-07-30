trigger SongAlbumAddTrigger on Song__c (before insert) {
    //Set para guardar los Ids de Artistas relacionados a las canciones.
    Set<Id> artistIds = new Set<Id>();

    //For para recorrer la lista de canciones y asignar los Ids de los artistas.
    for(Song__c s : Trigger.new){
        if(s.AlbumId__c == null && s.ArtistId__c != null){
            artistIds.add(s.ArtistId__c);
        }
    }

    if(!artistIds.isEmpty()){
        //Map para guardar los Ids de los Artistas relacionados a las canciones y el Album mas reciente de cada artista
        Map<Id, Album__c> latestAlbumMap = new Map<Id, Album__c>();

        //Consultar los álbumes más recientes por artista
        List<Album__c> albums = [
            SELECT Id, ArtistId__c, Release_Date__c
            FROM Album__c
            WHERE ArtistId__c IN :artistIds
            ORDER BY Release_Date__c DESC
            ];

        //for para recorrer las canciones y asignar el album mas reciente de cada artista    
        for(Album__c album : albums){
            if(!latestAlbumMap.containsKey(album.ArtistId__c)){
                latestAlbumMap.put(album.ArtistId__c, album);
            }
        }

        //for para recorrer las canciones y asignar el album que coincida con el Id del artista en el que se encuentra
        for(Song__c s : Trigger.new){
            if(s.AlbumId__c == null && latestAlbumMap.containsKey(s.ArtistId__c)){
                s.AlbumId__c = latestAlbumMap.get(s.ArtistId__c).Id;
            }
        }
    }
}

/*
Metodos:
-add: sirve para agregar elementos a un mapa, set y list
-containsKey: sirve para saber si un mapa tiene un elemento dentro
-get: sirve para obtener un elemento de un mapa
-put: sirve para agregar un elemento a un mapa
*/