public class SongTriggerHandler {

    public void beforeInsert(List<Song__c> newSongs) {
        Set<Id> artistIds = new Set<Id>();
        for (Song__c s : newSongs) {
            if (s.AlbumId__c == null && s.ArtistId__c != null) {
                artistIds.add(s.ArtistId__c);
            }
        }
        if (artistIds.isEmpty()) return;

        List<Album__c> albums = [
            SELECT Id, ArtistId__c, Release_Date__c
            FROM Album__c
            WHERE ArtistId__c IN :artistIds
            ORDER BY ArtistId__c, Release_Date__c DESC
        ];

        Map<Id, Album__c> latestAlbumByArtist = SongTriggerHelper.getLatestAlbumByArtist(albums);

        for (Song__c s : newSongs) {
            if (s.AlbumId__c == null && s.ArtistId__c != null) {
                Album__c latest = latestAlbumByArtist.get(s.ArtistId__c);
                if (latest != null) s.AlbumId__c = latest.Id;
            }
        }
    }
}
