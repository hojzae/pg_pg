/*
* @Class : UTIL_Trigger - Trigger 관련된 Util Class
*
* @Method : 
*	- getActiveSetting(triggerName)
* 
* @Author : Yong-jin, Cha
* @Date : 2019-11-06
* @Version : 1.0
* @Modified : 
*  ---------------------------------------------
*  NO | Date       | Modifier      | Description
*  ---------------------------------------------
*  1. | 2019-11-06 | Yong-jin, Cha | 최초작성
*  2. | 2022-07-06 | Ho-jae, Lee   | TEST
*/

public class UTIL_Trigger {
    public static ActiveSetting getActiveSEtting(String triggerName) {
        List<MT_Trigger_Active__mdt> TAList = [
            SELECT
                After_Delete__c
                , After_Insert__c
                , After_Undelete__c
                , After_Update__c
                , Before_Delete__c
                , Before_Insert__c
                , Before_Update__c
            FROM
                MT_Trigger_Active__mdt
            WHERE
                DeveloperName =:triggerName
            LIMIT 1
        ];
        // System.debug('TAList : ', TAList);
        if(TAList.size() == 0) {
            return new ActiveSetting(null);
        }

        return new ActiveSetting(TAList.get(0));

    }
    
    public class ActiveSetting {
        public Boolean isBeforeInsert {get;set;}
        public Boolean isBeforeUpdate {get;set;}
        public Boolean isBeforeDelete {get;set;}
        public Boolean isAfterInsert {get;set;}
        public Boolean isAfterUpdate {get;set;}
        public Boolean isAfterDelete {get;set;}
        public Boolean isAfterUndelete {get;set;}
        
        public ActiveSetting(MT_Trigger_Active__mdt	TA){
            
            triggerSwitch__c TS = triggerSwitch__c.getInstance();
            // System.debug('TS : ' + TS);
            if(TS.All_Active__c) {
                if(TA == null) {
                    this.isBeforeInsert = TS.Before_Insert__c;
                    this.isBeforeUpdate = TS.Before_Update__c;
                    this.isBeforeDelete = TS.Before_Delete__c;
                    this.isAfterInsert = TS.After_Insert__c;
                    this.isAfterUpdate = TS.After_Update__c;
                    this.isAfterDelete = TS.After_Delete__c;
                    this.isAfterUndelete = TS.After_Undelete__c;                    
                } else {
                    this.isBeforeInsert = TS.Before_Insert__c && TA.Before_Insert__c;
                    this.isBeforeUpdate = TS.Before_Update__c && TA.Before_Update__c;
                    this.isBeforeDelete = TS.Before_Delete__c && TA.Before_Delete__c;
                    this.isAfterInsert = TS.After_Insert__c && TA.After_Insert__c;
                    this.isAfterUpdate = TS.After_Update__c && TA.After_Update__c;
                    this.isAfterDelete = TS.After_Delete__c && TA.After_Delete__c;
                    this.isAfterUndelete = TS.After_Undelete__c && TA.After_Undelete__c;
                }
            } else {
                this.isBeforeInsert = false;
                this.isBeforeUpdate = false;
                this.isBeforeDelete = false;
                this.isAfterInsert = false;
                this.isAfterUpdate = false;
                this.isAfterDelete = false;
                this.isAfterUndelete = false;
            }
        }
    }
}