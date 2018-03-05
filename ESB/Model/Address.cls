Class ESB.Model.Address Extends (%SerialObject, %Populate, %XML.Adaptor)
{

Property type As %String;

Property addressline1 As %String;

Property postcode As %String;

Property city As %String;

Property country As %String;

Storage Default
{
<Data name="AddressState">
<Value name="1">
<Value>type</Value>
</Value>
<Value name="2">
<Value>addressline1</Value>
</Value>
<Value name="3">
<Value>postcode</Value>
</Value>
<Value name="4">
<Value>city</Value>
</Value>
<Value name="5">
<Value>country</Value>
</Value>
</Data>
<State>AddressState</State>
<StreamLocation>^ESB.Model.AddressS</StreamLocation>
<Type>%Library.CacheSerialState</Type>
}

}
