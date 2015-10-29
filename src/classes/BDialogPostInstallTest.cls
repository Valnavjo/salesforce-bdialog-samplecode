/**
 * @author      Josep Vall-llobera <valnavjo_at_gmail.com>
 * @version     1.0.0
 * @since       19/01/2013
 */
@IsTest
private class BDialogPostInstallTest {

	public static testMethod void testOnInstall() {
		InstallHandler postinstall = new BDialogPostInstall();

		Test.testInstall(postinstall, null);
		Test.testInstall(postinstall, new Version(1,0), true);

		final List<bigiant_dialog__bDialog__c> results = [select Id, Name,
																 bigiant_dialog__Visualforce_Page__c,
																 bigiant_dialog__External_content__c,
																 bigiant_dialog__Content_url__c
														  from bigiant_dialog__bDialog__c];
		System.assertEquals(results.size(), 4, 'Not found');

		for (bigiant_dialog__bDialog__c sfdcDialogResult : results) {
			if (sfdcDialogResult.Name == 'bigiant_dialog__open_sample_dialog') {
				System.assertEquals(sfdcDialogResult.bigiant_dialog__Visualforce_Page__c, 'bigiant_dialog__BDialogSample');
				System.assertNotEquals(null, sfdcDialogResult.bigiant_dialog__Content_url__c);
				
			} else if (sfdcDialogResult.Name == 'bigiant_dialog__open_sample_external_dialog') {
				System.assertEquals(null, sfdcDialogResult.bigiant_dialog__Visualforce_Page__c);
				System.assertEquals(true, sfdcDialogResult.bigiant_dialog__External_content__c);
				System.assertNotEquals(null, sfdcDialogResult.bigiant_dialog__Content_url__c);
				
			} else if (sfdcDialogResult.Name == 'bigiant_dialog__open_sample_internal_dialog') {
				System.assertEquals(sfdcDialogResult.bigiant_dialog__Visualforce_Page__c, 'YourVisualforcePage');
				System.assertNotEquals(null, sfdcDialogResult.bigiant_dialog__Content_url__c);
			}
		}
	}
}