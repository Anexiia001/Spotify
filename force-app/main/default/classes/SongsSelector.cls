public with sharing class SongsSelector {
    
    public static List<Song__c> getUpcomingSongs() {
        return [
            SELECT 
                    Id,
                    Name,
                    Release_Date__c
            FROM Song__c
            ORDER BY Release_Date__c ASC
            LIMIT 5
        ];
    }
 
    public static List<Song__c> getNewSongs(){
        return[
            SELECT
                Id,
                Name,
                Release_Date__c
            FROM Song__c
            ORDER BY Name ASC  
            LIMIT 5      
        ];
    }    
     
}