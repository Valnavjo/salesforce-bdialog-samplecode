/**
 * @author      Josep Vall-llobera <valnavjo_at_gmail.com>
 * @version     1.0.0
 * @since       19/01/2013
 */
@IsTest
private class BDialogTriggerHandlerTest {
	public static testMethod void testOnBeforeInsert() {
		bigiant_dialog__bDialog__c sfdcDialog = createSfdcDialog();
		
		insert sfdcDialog;
		
		sfdcDialog = [select Id, bigiant_dialog__Content_url__c
					  from bigiant_dialog__bDialog__c
					  where Name = 'my_sfdc_dialog'];
		System.assertNotEquals(null, sfdcDialog.bigiant_dialog__Content_url__c);
	}
	
	public static testMethod void testOnBeforeInsert_no_visualforce_page() {
		bigiant_dialog__bDialog__c sfdcDialog = createSfdcDialog();
		sfdcDialog.bigiant_dialog__Visualforce_Page__c = null;

		try {
			insert sfdcDialog;
		} catch (DMLException de) {
			System.assertEquals('You must introduce a value for \'Visualforce page\'.', de.getDmlMessage(0));
		}
	}
	
	public static testMethod void testOnBeforeInsert_no_content_url() {
		bigiant_dialog__bDialog__c sfdcDialog = createSfdcDialog();
		sfdcDialog.bigiant_dialog__Visualforce_Page__c = null;
		sfdcDialog.bigiant_dialog__External_content__c = true;
		sfdcDialog.bigiant_dialog__Content_url__c = null;
		
		try {
			insert sfdcDialog;
		} catch (DMLException de) {
			System.assertEquals('You must introduce a value for \'Content URL\'.', de.getDmlMessage(0));
		}
	}
	
	public static testMethod void testOnBeforeUpdate() {
		bigiant_dialog__bDialog__c sfdcDialog = createSfdcDialog();
		
		insert sfdcDialog;

		sfdcDialog = [select Id
					  from bigiant_dialog__bDialog__c
					  where Id = :sfdcDialog.Id];
		sfdcDialog.bigiant_dialog__External_content__c = true;
		update sfdcDialog;
		
		sfdcDialog = [select Id, bigiant_dialog__Visualforce_Page__c
					  from bigiant_dialog__bDialog__c
					  where Id = :sfdcDialog.Id];
		System.assertEquals(null, sfdcDialog.bigiant_dialog__Visualforce_Page__c);
	}
	
	private static bigiant_dialog__bDialog__c createSfdcDialog() {
		bigiant_dialog__bDialog__c sfdcDialog = new bigiant_dialog__bDialog__c();
		sfdcDialog.Name = 'my_sfdc_dialog';
		sfdcDialog.bigiant_dialog__Visualforce_Page__c = 'my_visualforce_page';
		sfdcDialog.bigiant_dialog__External_content__c = false;
		sfdcDialog.bigiant_dialog__Title__c = 'Sample Title';
		sfdcDialog.bigiant_dialog__Width__c = 600;
		sfdcDialog.bigiant_dialog__Height__c = 400;
		sfdcDialog.bigiant_dialog__Modal__c = true;
		
		return sfdcDialog;
	}
}