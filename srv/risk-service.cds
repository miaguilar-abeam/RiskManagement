using { riskmanagement as rm } from '../db/schema';

@ path: 'service/risk'
service RiskService {
//Start of Replace from Unit 5
  entity Risks @(restrict: [
{
grant : [ 'READ' ],
to : [ 'RiskViewer']    
},
{
grant : [ '*' ],
to : [ 'RiskManager' ]
}
]) as projection on rm.Risks;
//End   of Replace from Unit 5

    annotate Risks with @odata.draft.enabled;

//Start of Replace from Unit 5
  entity Mitigations @(restrict: [
{
grant : [ 'READ' ],
to : [ 'RiskViewer']    
},
{
grant : [ '*' ],
to : [ 'RiskManager' ]
}
]) as projection on rm.Mitigations;
//End   of Replace from Unit 5

    annotate Mitigations with @odata.draft.enabled;
  entity BusinessPartners as projection on rm.BusinessPartners;
}