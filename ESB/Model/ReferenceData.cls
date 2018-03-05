Class ESB.Model.ReferenceData Extends (%SerialObject, %Populate, %XML.Adaptor)
{

Property System As %String;

Property GUID As %String;

Storage Default
{
<Data name="ReferenceDataState">
<Value name="1">
<Value>System</Value>
</Value>
<Value name="2">
<Value>GUID</Value>
</Value>
</Data>
<State>ReferenceDataState</State>
<StreamLocation>^ESB.Model.ReferenceDataS</StreamLocation>
<Type>%Library.CacheSerialState</Type>
}

}
