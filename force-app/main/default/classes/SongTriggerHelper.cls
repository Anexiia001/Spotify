public class SongTriggerHelper {

    
    public static Map<Id, Album__c> getLatestAlbumByArtist(List<Album__c> albums) {
        Map<Id, Album__c> latestByArtist = new Map<Id, Album__c>();
        for (Album__c al : albums) {
            if (!latestByArtist.containsKey(al.ArtistId__c)) {
                latestByArtist.put(al.ArtistId__c, al);
            }
        }
        return latestByArtist;
    }
}
