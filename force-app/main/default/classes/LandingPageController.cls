public with sharing class LandingPageController {

    @AuraEnabled (cacheable=true)//Va en los controllers, esos son los que van directo al front, los selectors son privados
    public static List<Song__c> getUpcomingSongs(){
        return SongsSelector.getUpcomingSongs();
    }

    @AuraEnabled (cacheable=true)//Este atributo sirve para importar este metodo al frontend
    public static List<Song__c> getNewSongs(){
        return SongsSelector.getNewSongs();
    }

    @AuraEnabled (cacheable=true)
    public static List<Album__c> getAlbumes(){
        return AlbumsSelector.getAlbumes();
    }

    @AuraEnabled (cacheable=true)
    public static List<User_Playlist__c> getMainPlaylist(){
        return PlaylistsSelector.getMainPlaylist();
    }

    @AuraEnabled (cacheable=true)
    public static List<User_Playlist__c> getPlaylistPrivate(){
        return PlaylistsSelector.getPlaylistPrivate();
    }

    @AuraEnabled (cacheable=true)
    public static List<User_Playlist__c> getPlaylistPublic(){
        return PlaylistsSelector.getPlaylistPublic();
    }
}