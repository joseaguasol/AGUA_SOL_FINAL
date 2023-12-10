import pgPromise from 'pg-promise';

const pgp = pgPromise();

const connectionStr = "postgres://postgres:1234@localhost:5432/new_sol3";
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