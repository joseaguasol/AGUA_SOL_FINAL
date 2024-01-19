import pgPromise from 'pg-promise';

const pgp = pgPromise();

const connectionStr = "postgres://postgres:1234@localhost:5432/newsol2024";
<<<<<<< HEAD
//const connectionStr = "postgres://aguasol:TntaHgQf9msnfmHXdrQWEXHEt1hut1MC@dpg-cml86oacn0vc739oj51g-a/aguasol_ui5l";
=======

>>>>>>> 23f69f885cd7aa1fa924fadc72a731a5d547330d
//const connectionStr = "postgresql://postgres:5fDE6cgfda33eB4FFAabABgAggA4Ca-c@viaduct.proxy.rlwy.net:35474/railway";
export const db_pool =  pgp(connectionStr);

try{
    db_pool.connect()
    .then(obj=>{
        console.log("AGUA SOL DB CONNECTED !");
        obj.done();
    })
    .catch(err=>{
        console.log("NO CONNECTED AGUA SOL:",err);
    })
}
catch(err){
    console.log(`ERROR CONFIGURATION: ${err}`);
}