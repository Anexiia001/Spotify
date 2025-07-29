public with sharing class PlaylistsSelector {
    
    public static List<User_Playlist__c> getMainPlaylist(){
        return[
            SELECT 
                Id,        
                Name__c,
                Cant_Songs__c,
                Playlist_Time_Duration__c
            FROM User_Playlist__c
            WHERE UserId__c = '01Ibm000004NMLh'
            ORDER BY LastModifiedDate DESC 
            LIMIT 5
        ];
    }

    public static List<User_Playlist__c> getPlaylistPrivate(){
        return[
            SELECT
                Id,
                Name__c,
                Cant_Songs__c,
                Playlist_Time_Duration__c,
                IsPublic__c
            FROM User_Playlist__c
            WHERE IsPublic__c = false
        ];
    }
    
    public static List<User_Playlist__c> getPlaylistPublic(){
        return[
            SELECT
                Id,
                Name__c,
                Cant_Songs__c,
                Playlist_Time_Duration__c,
                IsPublic__c
            FROM User_Playlist__c
            WHERE IsPublic__c = true
        ];
    }  
}