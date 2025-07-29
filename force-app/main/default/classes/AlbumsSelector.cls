public with sharing class AlbumsSelector {
    
    public static List<Album__c> getAlbumes(){
        return[
            SELECT 
                Id,
                Name,
                Release_Date__c
            FROM Album__c
            ORDER BY Release_Date__c ASC
        ];
    }

}