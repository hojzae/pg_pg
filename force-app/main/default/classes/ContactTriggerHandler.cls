public with sharing class ContactTriggerHandler {

    private Boolean isExecuting {get; set;} // Web Service와 구분하기 위한 Context 파라미터
    private Integer size {get; set;} // Trigger에서 Execute된 List Size

    public ContactTriggerHandler(Boolean isExecuting, Integer size) {
        this.isExecuting = isExecuting;
        this.size = size;
        // console.log('#isExecuting [' + isExecuting + '] #size [' + size + ']');
    }

    public void onBeforeInsert(List<Contact> news) {
        // console.log('온 비포 인서트');
        if(isExecuting) {
            // Contact cnt = new Contact();
            List<Contact> cntList = new List<Contact>();
            for(Contact cnt : news) {
                cnt.Description = cnt.Description + 'Contact created sucessfully by using TriggerTest trigger!';
                cnt.Phone = '01066676805';
                cntList.add(cnt);
                // update cnt;
            }
        }
    }
}