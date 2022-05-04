// Written by: Reid Efford https://github.com/effordDev
public without sharing class LightningLockHelper {
    
    @AuraEnabled
    public static Boolean isLocked(Id recordId) {
        return Approval.isLocked(recordId);
    
    }

    @AuraEnabled
    public static Boolean lock(Id recordId) {
    
        Approval.lock(recordId);
        return true;
    }

    @AuraEnabled
    public static Boolean unlock(Id recordId) {
        Approval.unlock(recordId);
        return false;
    }
}
