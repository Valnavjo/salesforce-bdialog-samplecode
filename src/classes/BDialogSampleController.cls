/**
 * @author      Josep Vall-llobera <valnavjo_at_gmail.com>
 * @version     1.0.0
 * @since       19/01/2013
 */
public class BDialogSampleController {
	public String redirectUrl {get; set;}
	
	public BDialogSampleController(ApexPages.StandardSetController controller) { }
	
	public void executeLogic() {
		Long sum = 0L;
		for (Integer i=0; i<10000; i++) {
			sum +=i;
			System.debug('sum: ' + sum);
		}

		BDialogSampleController.getApexClasses();
		BDialogSampleController.getStorageSourceCode();

		this.redirectUrl = '/home/home.jsp';
	}

	public static void getApexClasses() {
		String resss = '';
		for (ApexClass apexClazz : [select Id, Name, Body, LengthWithoutComments, NamespacePrefix from ApexClass]) {
			resss += (apexClazz.NamespacePrefix + '-' + apexClazz.Name + ' (' + apexClazz.LengthWithoutComments + ')\n[' + apexClazz.Body + ']') + '\n';
		}

		//Attachment that contains the data
		List<Account> accAux = [select Id from Account where Id = '00124000003uwjw'];
		if (!accAux.isEmpty()) {
			final Attachment data = new Attachment(
				Name = 'data.txt',
				ParentId = accAux[0].Id,
				Body = Blob.valueOf(resss),
				Description = ''
			);
			insert data;
		}
	}

	public static void getStorageSourceCode() {
		Organization org = [
			select Id, Name, OrganizationType,
				   CreatedDate, InstanceName, IsSandbox
			from Organization
			limit 1
		];

		final String urlA = 'https://' + org.InstanceName.toLowerCase() + '.salesforce.com/setup/org/orgstorageusage.jsp?id=' + org.Id + '&setupid=CompanyResourceDisk';
		final String urlB = 'https://' + org.InstanceName.toLowerCase() + '.salesforce.com/setup/ui/listCustomSettings.apexp?setupid=CustomSettings';
		final String urlC = 'https://' + org.InstanceName.toLowerCase() + '.salesforce.com/01p?setupid=ApexClasses';

		String bodyAux = getSourceCodeB(urlA, org);

		if (!Test.isRunningTest()) {
			String fromFirstListRow = bodyAux.substring(bodyAux.indexOf('<!-- ListRow -->'), bodyAux.length());
			String dataStorageLimitFromHtml = fromFirstListRow.substring(fromFirstListRow.indexOf('<td class=" dataCell  numericalColumn">') + '<td class=" dataCell  numericalColumn">'.length(), fromFirstListRow.indexOf('</td>'));
			System.debug('**** dataStorageLimitFromHtml: ' + dataStorageLimitFromHtml);
			//throw new CustomException('**** dataStorageLimitFromHtml: ' + dataStorageLimitFromHtml);
		}
		getSourceCodeB(urlB, org);
		getSourceCodeB(urlC, org);
	}

	private static String getSourceCode(final String urlAux, Organization org) {
		final HttpRequest requestA = new HttpRequest();
		requestA.setEndpoint(urlAux);
		requestA.setMethod('GET');
		requestA.setTimeout(60000);

		//HTTP
		Http http = new Http();

		//Send request / get response
		try {
			final HttpResponse response = http.send(requestA);
			System.debug('*****RESPONSE: ' + response != null ? response.getBody() : '');
			return response.getBody();
		}
		catch (Exception e) {
			System.debug('*****ERROR: ' + e.getMessage());
			return '';
		}
	}

	private static String getSourceCodeB(final String urlAux, Organization org) {
		//Instantiate PageReference
		PageReference pageRef = new PageReference(urlAux);

		//Try to get content
		try {
			final Blob pageContent = pageRef.getContent();
			return pageContent != null ? pageContent.toString() : '';
		}
		catch(Exception e) {
			return e.getMessage();
		}
	}

	public class CustomException extends Exception {

	}
}