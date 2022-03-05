//Imports
const cds = require("@sap/cds");

/**
* The service implementation with all service handlers
*/
module.exports = cds.service.impl(async function () {
    /**
    * Custom Error handler
    * 
    * throw a new error with: throw new Error('something bad happened');
    *
    **/
    //this.on("error",(err,req)=>{
    //   switch(err.message){
    //    case"UNIQUE_CONSTRAINT_VIOLATION":
    //    err.message="The entry already exists.";
    //    break;

    //    default:
    //    err.message=
    //    "An error occured. Please retry. Technical error message: "+
    //    err.message;
    //    break;
    //    }
    //    });
    //  });

    //Define constants for the Risk and BusinessPartner entities 
    //from the risk-service.cds file
    const { Risks, BusinessPartners } = this.entities;

    /**
    * Set criticality after a READ operation on /risks
    */
    this.after("READ", Risks, (data) => {
        const risks = Array.isArray(data) ? data : [data];

        //The criticality set here is used in the annotations.cds
        risks.forEach((risk) => {
            if (risk.impact >= 100000) {
                risk.criticality = 1;
            } else {
                risk.criticality = 2;
            }
        });
    });

    //### BEGIN OF INSERT From Unit 3 Lesson 1

    // connect to remote service
    const BPsrv = await cds.connect.to("API_BUSINESS_PARTNER");

    /**
    * Event-handler for read-events on BusinessPartners entity.
    * Each requests to the API Business Hub requires the API Key in the header.
    */
    this.on("READ", BusinessPartners, async (req) => {
        // The API Sandbox returns a lot of business partners with empty names.
        // We don't want them in our application.
        req.query.where("LastName <> '' and FirstName <> '' ");

        return await BPsrv.transaction(req).send({
            query: req.query,
            headers: {
                apikey: process.env.apikey,
            },
        });
    });
    //### END   OF INSERT From Unit 3 Lesson 1

    //### BEGIN OF INSERT UNIT 3 LESSON 2

    /**
    * Event-handler on risks.
    * Retrieve BusinessPartner data from external API
    */

    this.on("READ", Risks, async (req, next) => {
        /*
        Check whether the requests wants an "expand" of the business partner.
        As this is not possible, the risk entity and the business partner
        entity are in different systems (SAP BTYP and S/4 HANA Cloud),
        if there is such an expand, remove it
        */
        /* 
        the line "if (!req.query.SELECT.columns) return next(); was not
        mentioned in the ebook of CLD200. This was taken from 
        https://developers.sap.com/tutorials/btp-app-ext-service-consume-ui.html
        */
        if (!req.query.SELECT.columns) return next();
        const expandIndex = req.query.SELECT.columns.findIndex(
            ({ expand, ref }) => expand && ref[0] === "bp"
	    );
        console.log(req.query.SELECT.columsn);
        if (expandIndex < 0) return next();

        req.query.SELECT.columns.splice(expandIndex, 1);
        if (
            !req.query.SELECT.columns.find((column) =>
                column.ref.find((ref) => ref == "bp_BusinessPartner")
            )
        ) {
            req.query.SELECT.columns.push({ ref: ["bp_BusinessPartner"] });
        }

        /*
        Insted of carrying out the expand, issues a spearate request for 
        each business partner
        This code could be optimized, instead of having n requests for n 
        business partners, just one bulk request could be created
        */
        
        try {
            const res = await next();
            await Promise.all(
                res.map(async (risk) => {
                    const bp = await BPsrv.transaction(req).send({
                        query: SELECT.one(this.entities.BusinessPartners)
                            .where({ BusinessPartner: risk.bp_BusinessPartner })
                            .columns(["BusinessPartner", "LastName", "FirstName"]),
                        headers: {
                            apikey: process.env.apikey,
                        },
                    });
                    risk.bp = bp;
                })
            );
                    
        //There is an error when using the '{}' with the catch (error)
        //The Show fixes has to be used to fix the error and the 
        //'eslint-disable-next-line no empty' is added             
        // eslint-disable-next-line no-empty
        } catch (error) {}
     });
    //### END   OF INSERT UNIT 3 LESSON 2

 });