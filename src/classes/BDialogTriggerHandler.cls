/**
 * @author      Josep Vall-llobera <valnavjo_at_gmail.com>
 * @version     1.0.0
 * @since       19/01/2013
 */
public class BDialogTriggerHandler {

	/**SINGLETON PATTERN*/
	private static BDialogTriggerHandler instance;
	public static BDialogTriggerHandler getInstance() {
		if (instance == null) instance = new BDialogTriggerHandler();
		return instance;
	}
	
	/*PUBLIC METHODS*/
	/**
	 * Before insert
	 */
	public void onBeforeInsert(final List<bigiant_dialog__bDialog__c> newObjects) {
		for (bigiant_dialog__bDialog__c sfdcDialog : newObjects) {
			fillContentUrl(sfdcDialog);
		}
	}
	
	/**
	 * Before Update
	 */
	public void onBeforeUpdate(final List<bigiant_dialog__bDialog__c> oldObjects, final Map<Id, bigiant_dialog__bDialog__c> oldObjectsMap,
							   final List<bigiant_dialog__bDialog__c> newObjects, final Map<Id, bigiant_dialog__bDialog__c> newObjectsMap) {
		for (bigiant_dialog__bDialog__c sfdcDialog : newObjects) {
			fillContentUrl(sfdcDialog);
		}
	}
	
	/*PRIVATE METHODS*/
	/**
	 *
	 */
	private static void fillContentUrl(final bigiant_dialog__bDialog__c sfdcDialog) {
		if (!sfdcDialog.bigiant_dialog__External_content__c) {
			String vfName = sfdcDialog.bigiant_dialog__Visualforce_Page__c;
			if (vfName == null) vfName = '';
			String vfUrl = null;
	
			String instanceAux = '';
			String[] parts = System.URL.getSalesforceBaseUrl().getHost().replace('-api', '').split('\\.');
			if (parts.size() == 3) instanceAux = parts[0];
			else if (parts.size() == 5) instanceAux = parts[1];
			else instanceAux = 'undefined';
			
			String namespaceAux = '';
			if (vfName.contains('__')) {
				namespaceAux = vfName.substring(0, vfName.indexOf('__')).replace('_', '-');
			} else {
				namespaceAux = 'c';
			}
			
			sfdcDialog.bigiant_dialog__Content_url__c = 'https://' + namespaceAux + '.' + instanceAux + '.visual.force.com/apex/' + vfName;
		} else {
			sfdcDialog.bigiant_dialog__Visualforce_Page__c = null;
		}
	}
}