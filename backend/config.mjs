import pgPromise from 'pg-promise';

const pgp = pgPromise();

<<<<<<< HEAD
const connectionStr = "postgres://postgres:1234@localhost:5432/newsol2024";
//const connectionStr = "postgresql://postgres:5fDE6cgfda33eB4FFAabABgAggA4Ca-c@viaduct.proxy.rlwy.net:35474/railway";
=======
//const connectionStr = "postgres://postgres:1234@localhost:5432/newsol2024";
const connectionStr = "postgres://aguasol:TntaHgQf9msnfmHXdrQWEXHEt1hut1MC@dpg-cml86oacn0vc739oj51g-a/aguasol_ui5l";
>>>>>>> 94753e9be950841742b2c6bb4a3738deac9d9584
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