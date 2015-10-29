/**
 * @author      Josep Vall-llobera <valnavjo_at_gmail.com>
 * @version     1.0.0
 * @since       19/01/2013
 */
trigger bDialog on bigiant_dialog__bDialog__c (before insert, before update) {
	final BDialogTriggerHandler handler = BDialogTriggerHandler.getInstance();
	
	//-- Before Insert
	if (Trigger.isInsert && Trigger.isBefore) {
		handler.onBeforeInsert(Trigger.new);
	}

	//-- Before Update
	else if (Trigger.isUpdate && Trigger.isBefore) {
		handler.onBeforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
	}

	
}