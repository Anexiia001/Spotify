public with sharing class PlaylistSongTriggerHelper {

    public static void preventDuplicateInsertion(List<Playlist_Song__c> newPlaylistSongs) {
       Set<Id> playlistSongIds = new Set<Id>();
       Set<String> existingPlaylistSongs = new Set<String>();

       // Iterar Trigger.New para almacenar los Id de las User_Playlist__c.
       for (Playlist_Song__c playlistSong : newPlaylistSongs) {
          playlistSongIds.add(playlistSong.User_Playlist__c);
       }

       // Query de User_Playlist__c para obtener todas las Canciones relacionadas.
       List<User_Playlist__c> userPlaylists = [SELECT Id, Name, (SELECT Id, Name, Song__c FROM Playlist_Songs__r) FROM User_Playlist__c WHERE Id IN :playlistSongIds];

       // Iterar sobre query de User_Playlist__c para generar duplicateKeys
       for (User_Playlist__c userPlaylist : userPlaylists) {
          for (Playlist_Song__c playlistSong : userPlaylist.Playlist_Songs__r) {
             String duplicateKey = String.valueOf(userPlaylist.Id) + String.valueOf(playlistSong.Song__c);
             existingPlaylistSongs.add(duplicateKey);
          }
       }

       // Iterar Trigger.new y crear duplicateKey de cada registro para comparar con la lista de duplicateKeys
       for (Playlist_Song__c playlistSong : newPlaylistSongs) {
          String duplicateKey = String.valueOf(playlistSong.User_Playlist__c) + String.valueOf(playlistSong.Song__c);

          if (existingPlaylistSongs.contains(duplicateKey)) {
             playlistSong.addError('La cancion ' + playlistSong.Song__c + ' ya existe dentro de la playlist ' + playlistSong.User_Playlist__c);
          }
       }
    }
}