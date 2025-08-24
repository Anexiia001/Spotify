trigger SongTrigger on Song__c (before insert) {
    SongTriggerHandler handler = new SongTriggerHandler();

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            handler.beforeInsert(Trigger.new);
        }
    }
}
