Class ESB.REST.PersonService Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/PersonService/XML/:GUID" Method="GET" Call="GetPersonXML"/>
<Route Url="/PersonService/:GUID" Method="GET" Call="GetPersonJSON"/>
<Route Url="/CreatePerson" Method="POST" Call="CreatePerson"/>
</Routes>
}

/// Create or replace
ClassMethod CreatePerson() As %Status
{
	set tSC=$$$OK
	
	set JSONObj = ##class(%DynamicObject).%FromJSON(%request.Content)
	set tPersonObj=##class(ESB.Model.EnrichedPerson).%New()
	set tPersonObj.system=JSONObj.system
	set tPersonObj.firstname=JSONObj.firstname
	set tPersonObj.lastname=JSONObj.lastname
	set tPersonObj.email=JSONObj.email
	set tPersonObj.phonenumber=JSONObj.phonenumber
	set tPersonObj.dob=JSONObj.dob
	set tPersonObj.title=JSONObj.title
	set tPersonObj.gender=JSONObj.gender
	set tPersonObj.Xref.System=JSONObj.Xref.System
	set tPersonObj.Xref.GUID=JSONObj.Xref.GUID
	set iterator = JSONObj.addresses.%GetIterator()
	While iterator.%GetNext(.key,.val){
		set taddress=##class(ESB.Model.Address).%New()
		set taddress.type=JSONObj.addresses.%Get(key).type
		set taddress.city=JSONObj.addresses.%Get(key).city
		set taddress.addressline1=JSONObj.addresses.%Get(key).addressline1
		set taddress.postcode=JSONObj.addresses.%Get(key).postcode
		set taddress.country=JSONObj.addresses.%Get(key).country
		do tPersonObj.addresses.SetAt(taddress,key)
	}	
	Set tSC=tPersonObj.%Save()  Quit:$$$ISERR(tSC)
	Write tPersonObj.Xref.GUID,!

	Quit tSC
}

ClassMethod GetPersonXML(pGuid As %String) As %Status
{
	Try {
		set tSC=$$$OK
		set Id=""
		set Id=..GetPersonId(pGuid)
		s obj=##class(ESB.Model.EnrichedPerson).%OpenId(Id)
		If $IsObject(obj){
			s tSC=obj.XMLExportToStream(.tStream)
			Do tStream.Rewind()  
			#; Return the results
    		Set tSC=tStream.OutputToDevice()
    		Set %response.ContentType=%request.ContentType
		}	
        
    } catch (e) {
        Set tSC=e.AsStatus()
    }
	q tSC
}

ClassMethod GetPersonJSON(pGuid As %String) As %Status
{
	Try {
		set tSC=$$$OK
		set Id=""
		set Id=..GetPersonId(pGuid)
		s obj=##class(ESB.Model.EnrichedPerson).%OpenId(Id)
		If $IsObject(obj){
			s tSC=##class(%ZEN.Auxiliary.jsonProvider).%WriteJSONStreamFromObject(.tStream,obj,"","",1,"n")
			Do tStream.Rewind()  
			#; Return the results
		
			Set tSC=tStream.OutputToDevice()
			Set %response.ContentType=%request.ContentType
		}
        
    } catch (e) {
        Set tSC=e.AsStatus()
    }
	q tSC
}

ClassMethod GetPersonId(GUID As %String) As %String
{
	set tID=""
	Set tStatement = ##class(%SQL.Statement).%New()
	Set tSQL = ""	
	Set tSQL = "select ID from ESB_model.EnrichedPerson b Where Xref_GUID="_"'"_GUID_"'"
	Set tSC = tStatement.%Prepare(tSQL)
	Set tResult = tStatement.%Execute()
	While tResult.%Next(){
		set tID=tResult.ID
	}	
	quit tID
}

}
