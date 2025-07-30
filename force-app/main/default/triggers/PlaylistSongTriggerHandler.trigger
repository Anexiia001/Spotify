public with sharing class PlaylistSongTriggerHandler {


    public static void beforeInsert(List<Playlist_Song__c> newPlaylistSongs) {
       PlaylistSongTriggerHelper.preventDuplicateInsertion(newPlaylistSongs);
    }

    public static void beforeUpdate(List<Playlist_Song__c> newPlaylistSongs) {

    }

}

