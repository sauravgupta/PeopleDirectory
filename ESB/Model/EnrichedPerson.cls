Class ESB.Model.EnrichedPerson Extends (%Persistent, %Populate, %XML.Adaptor)
{

Property system As %String;

Property firstname As %String;

Property lastname As %String;

Property email As %String;

Property phonenumber As %String;

Property dob As %String;

Property title As %String;

Property gender As %String;

Property addresses As array Of Address;

Property Xref As ESB.Model.ReferenceData;

Storage Default
{
<Data name="EnrichedPersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>system</Value>
</Value>
<Value name="3">
<Value>firstname</Value>
</Value>
<Value name="4">
<Value>lastname</Value>
</Value>
<Value name="5">
<Value>email</Value>
</Value>
<Value name="6">
<Value>phonenumber</Value>
</Value>
<Value name="7">
<Value>dob</Value>
</Value>
<Value name="8">
<Value>title</Value>
</Value>
<Value name="9">
<Value>gender</Value>
</Value>
<Value name="10">
<Value>Xref</Value>
</Value>
</Data>
<Data name="addresses">
<Attribute>addresses</Attribute>
<Structure>subnode</Structure>
<Subscript>"addresses"</Subscript>
</Data>
<DataLocation>^ESB.Model.EnrichedPersonD</DataLocation>
<DefaultData>EnrichedPersonDefaultData</DefaultData>
<IdLocation>^ESB.Model.EnrichedPersonD</IdLocation>
<IndexLocation>^ESB.Model.EnrichedPersonI</IndexLocation>
<StreamLocation>^ESB.Model.EnrichedPersonS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
