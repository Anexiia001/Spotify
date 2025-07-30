trigger PlaylistSongTrigger on Playlist_Song__c (before insert) {

    if (Trigger.isBefore) {
       if (Trigger.isInsert) {
          PlaylistSongTriggerHandler.beforeInsert(Trigger.new);
       }
       if (Trigger.isUpdate) {
          PlaylistSongTriggerHandler.beforeUpdate(Trigger.new);
       }
    }

}


