/**
 * @author      Josep Vall-llobera <valnavjo_at_gmail.com>
 * @version     1.0.0
 * @since       19/01/2013
 */
@IsTest
private class BDialogSampleControllerTest {
	public static testMethod void testExecuteLogic() {
		//-- Prepare data
		BDialogSampleController controller = new BDialogSampleController(null);
		
		//-- Do test
		Test.startTest();
		controller.executeLogic();
		Test.stopTest();
		
		//-- Assertions
		System.assertNotEquals(null, controller.redirectUrl);
		System.assertEquals('/home/home.jsp', controller.redirectUrl);
	}
}