@isTest
public with sharing class LightningLockHelperTest {
    
    @TestSetup
    private static void makeData(){
        Contact c = new Contact();
            c.FirstName = 'John';
            c.LastName = 'Lock';
        insert c;
    }

    @isTest
    private static void isLockedTest() {
        Contact c = [SELECT Id, Name FROM Contact LIMIT 1];

        Boolean locked = LightningLockHelper.isLocked(c.Id);

        system.assertEquals(false, locked);
    }

    // @isTest
    // private static void negativeIsLockedTest() {
    //     Boolean locked = LightningLockHelper.isLocked(null);
    // }

    @isTest
    private static void isLockedUnlockedTest() {
        Contact c = [SELECT Id, Name FROM Contact LIMIT 1];

        Boolean locked = LightningLockHelper.lock(c.Id);
        system.assertEquals(true, locked);
        
        locked = LightningLockHelper.unlock(c.Id);
        system.assertEquals(false, locked);
    }

    // @isTest
    // private static void negativeLockTest() {
    //     Boolean locked = LightningLockHelper.lock(null);
    // }
    // @isTest
    // private static void negativeUnlockTest() {
    //     Boolean locked = LightningLockHelper.unlock(null);
    // }
}
