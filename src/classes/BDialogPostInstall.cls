/**
 * @author      Josep Vall-llobera <valnavjo_at_gmail.com>
 * @version     1.0.0
 * @since       19/01/2013
 */
global class BDialogPostInstall implements InstallHandler {
	
	global void onInstall(InstallContext context) {
		if (context.previousVersion() == null) {
			final List<bigiant_dialog__bDialog__c> sfdcDialogs = new List<bigiant_dialog__bDialog__c>();

			//Add Dialog for internal content sample
			sfdcDialogs.add(
					new bigiant_dialog__bDialog__c(
						Name = 'bdialog_sample',
						bigiant_dialog__Visualforce_Page__c = 'bigiant_dialog__BDialogSample',
						bigiant_dialog__Standard_style__c = 'start',
						bigiant_dialog__Title__c = 'Sample Title',
						bigiant_dialog__Width__c = 600,
						bigiant_dialog__Height__c = 400,
						bigiant_dialog__Resizable__c = false,
						bigiant_dialog__Modal__c = true,
						bigiant_dialog__Draggable__c = false,
						bigiant_dialog__Scrolling__c = true,
						bigiant_dialog__Close_on_escape__c = true,
						bigiant_dialog__Hide_titlebar_close__c = false,
						bigiant_dialog__Position__c = 'center',
						bigiant_dialog__Show_effect__c = null,
						bigiant_dialog__Hide_effect__c = null
				)
			);
			
			//Add Dialog for external content (php page from valnavjo server)
			sfdcDialogs.add(
					new bigiant_dialog__bDialog__c(
						Name = 'bdialog_sample_external',
						bigiant_dialog__Visualforce_Page__c = null,
						bigiant_dialog__External_content__c = true,
						bigiant_dialog__Content_url__c = 'http://www.valnavjo.com/samples/dialog_content.php',
						bigiant_dialog__Standard_style__c = 'start',
						bigiant_dialog__Title__c = 'Sample Title',
						bigiant_dialog__Width__c = 800,
						bigiant_dialog__Height__c = 300,
						bigiant_dialog__Resizable__c = false,
						bigiant_dialog__Modal__c = true,
						bigiant_dialog__Draggable__c = false,
						bigiant_dialog__Scrolling__c = false,
						bigiant_dialog__Close_on_escape__c = true,
						bigiant_dialog__Hide_titlebar_close__c = false,
						bigiant_dialog__Position__c = 'right bottom',
						bigiant_dialog__Show_effect__c = 'bounce',
						bigiant_dialog__Hide_effect__c = 'slide'
				)
			);
			
			//Add fake 'YourPage'
			sfdcDialogs.add(
					new bigiant_dialog__bDialog__c(
						Name = 'bdialog_sample_internal',
						bigiant_dialog__Visualforce_Page__c = 'YourVisualforcePage',
						bigiant_dialog__Standard_style__c = 'start',
						bigiant_dialog__Title__c = 'Sample Title',
						bigiant_dialog__Width__c = 600,
						bigiant_dialog__Height__c = 400,
						bigiant_dialog__Resizable__c = false,
						bigiant_dialog__Modal__c = true,
						bigiant_dialog__Draggable__c = false,
						bigiant_dialog__Scrolling__c = false,
						bigiant_dialog__Close_on_escape__c = true,
						bigiant_dialog__Hide_titlebar_close__c = false,
						bigiant_dialog__Position__c = 'left top',
						bigiant_dialog__Show_effect__c = 'explode',
						bigiant_dialog__Hide_effect__c = 'shake'
				)
			);
			
			//Add Dialog to open from inside another Dialog
			sfdcDialogs.add(
					new bigiant_dialog__bDialog__c(
						Name = 'bdialog_sample_inner',
						bigiant_dialog__Visualforce_Page__c = 'bigiant_dialog__BDialogSampleInner',
						bigiant_dialog__Standard_style__c = 'hot-sneaks',
						bigiant_dialog__Title__c = 'Sample Title',
						bigiant_dialog__Width__c = 300,
						bigiant_dialog__Height__c = 200,
						bigiant_dialog__Resizable__c = true,
						bigiant_dialog__Modal__c = false,
						bigiant_dialog__Draggable__c = true,
						bigiant_dialog__Scrolling__c = true,
						bigiant_dialog__Close_on_escape__c = false,
						bigiant_dialog__Hide_titlebar_close__c = true,
						bigiant_dialog__Position__c = 'bottom',
						bigiant_dialog__Show_effect__c = 'clip',
						bigiant_dialog__Hide_effect__c = 'blind'
				)
			);
			
			insert sfdcDialogs;
		}
	}
}