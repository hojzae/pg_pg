trigger TriggerTest on Contact (before insert, before delete, before update, after delete, after update, after undelete) {
    // Trigger.New가 콘택트의 새버전을 가지고 있다.
    // DML 작성 할 필요가 없다 NEW가 들고있다.
    /*for(Contact cnt : Trigger.new) {
        if(cnt.Description != null) {
            cnt.Description = cnt.Description + 'Contact created sucessfully by using TriggerTest trigger!';
            cnt.Phone = '01066676805';
        }
    }*/
    UTIL_Trigger.ActiveSetting TAS = UTIL_Trigger.getActiveSetting('TriggerTest');
    ContactTriggerHandler handler = new ContactTriggerHandler(Trigger.isExecuting, Trigger.size);
    
    switch on Trigger.OperationType {
        when  Before_Insert{
            if(TAS.isBeforeInsert) {
                handler.onBeforeInsert(Trigger.new);
            }
        }
    }
}