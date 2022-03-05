using RiskService as service from '../../srv/risk-service';

// Risk List Report Page
annotate RiskService.Risks with @(UI : {
HeaderInfo  : {
    TypeName : 'Risk',
    TypeNamePlural : 'Risks',
    Title : {
    $Type : 'UI.DataField',
    Value : title
    },
    Description : { 
    $Type : 'UI.DataField',
    Value : descr
    }
    },    
SelectionFields : [prio],
Identification : [{Value : Title}],
//Define Table columns
LineItem : [
{Value : title },
{Value : miti_ID},
{Value : owner},
//BEGIN OF INSERT Unit 3 Lesson 1
{Value : bp_BusinessPartner},
//END   OF INSERT Unit 3 Lesson 1
{Value : prio, Criticality : criticality},
{Value : impact, Criticality : criticality},
],
});

// Risk Object Page 
annotate RiskService.Risks with @(UI : {
Facets : [{ 
$Type : 'UI.ReferenceFacet',
Label : 'Main',
Target : '@UI.FieldGroup#Main',
}],
FieldGroup #Main : {Data : [
{Value : miti_ID},
{Value : owner},
//BEGIN OF INSERT Unit 3 Lesson 1
{Value : bp_BusinessPartner},
//END OF INSERT Unit 3 Lesson 1
{
Value : prio, 
Criticality : criticality
},
{
Value : impact, Criticality : criticality
}
]},
});

// The following codes below were already available when 
// the annotations.cds were generated
//annotate service.Risks with @(
//    UI.LineItem : [
//        {
//            $Type : 'UI.DataField',
//            Label : 'title',
//            Value : title,
//        },
//        {
//           $Type : 'UI.DataField',
//            Label : 'owner',
//           Value : owner,
//        },
//       {
//            $Type : 'UI.DataField',
//            Label : 'prio',
//            Value : prio,
//        },
//        {
//            $Type : 'UI.DataField',
//            Label : 'descr',
//            Value : descr,
//        },
//        {
//            $Type : 'UI.DataField',
//            Label : 'impact',
//            Value : impact,
//        },
//    ]
//);
//annotate service.Risks with @(
//    UI.FieldGroup #GeneratedGroup1 : {
//        $Type : 'UI.FieldGroupType',
//        Data : [
//            {
//                $Type : 'UI.DataField',
//                Label : 'title',
//                Value : title,
//            },
//            {
//                $Type : 'UI.DataField',
//                Label : 'owner',
//                Value : owner,
//            },
//            {
//                $Type : 'UI.DataField',
//                Label : 'prio',
//                Value : prio,
//            },
//            {
//                $Type : 'UI.DataField',
//                Label : 'descr',
//                Value : descr,
//            },
//            {
//                $Type : 'UI.DataField',
//                Label : 'impact',
//                Value : impact,
//            },
//            {
//                $Type : 'UI.DataField',
//                Label : 'criticality',
//                Value : criticality,
//            },
//       ],
//    },
//    UI.Facets : [
//        {
//            $Type : 'UI.ReferenceFacet',
//            ID : 'GeneratedFacet1',
//            Label : 'General Information',
//            Target : '@UI.FieldGroup#GeneratedGroup1',
//        },
//    ]
//);