using riskmanagement as rm from '../db/schema';

//Annotate Risk elements
annotate rm.Risks with {
ID @title : 'Risk';
title @title : 'Title';
owner @title : 'Owner';
prio @title : 'Priority';
descr @title : 'Description';
miti @title : 'Mitigation';
impact @title : 'Impact';
//BEGIN OF Insert from Unit 3 Lesson 1
bp @title : 'Business Partner';
//END   OF Insert from Unit 3 Lesson 1
criticality @title : 'Criticality';
}

annotate rm.Mitigations with {
ID @(
    UI.Hidden,
    Commong : {Text, descr}
    );
owner @title : 'Owner';
descr @title : 'Description';    
}

//BEGIN OF Insert from Unit 3 Lesson 1
annotate rm.BusinessPartners with {
BusinessPartner @(
UI.Hidden, 
Common : {Text : LastName}
);
LastName @title : 'Last Name';
FirstName @title : 'First Name';    
}
//END   OF Insert from Unit 3 Lesson 1

annotate rm.Risks with {
miti @(Common : {
//show text, not id for mitigation in the context of risks
Text : miti.descr,
TextArrangement : #TextOnly,
ValueList : {
Label : 'Mitigations',
CollectionPath : 'Mitigations',
Parameters : [
{
$Type : 'Common.ValueListParameterInOut',
LocalDataProperty : miti_ID,
ValueListProperty : 'ID'
},
{
$Type : 'Common.ValueListParameterDisplayOnly',
ValueListProperty : 'descr'
}
]
}
});    
//}

//BEGIN OF Insert from Unit 3 Lesson 1
bp @(Common : {
Text : bp.LastName,
TextArrangement : #TextOnly,
ValueList : {
Label : 'Business Partners',
CollectionPath : 'BusinessPartners',
Parameters : [
{
$Type : 'Common.ValueListParameterInOut',
LocalDataProperty : bp_BusinessPartner,
ValueListProperty : 'BusinessPartner'
},
{
$Type : 'Common.ValueListParameterDisplayOnly',
ValueListProperty : 'LastName'
},
{                 
$Type : 'Common.ValueListParameterDisplayOnly',
ValueListProperty : 'FirstName'
}
]
}
})
//END   OF Insert from Unit 3 Lesson 1
} 