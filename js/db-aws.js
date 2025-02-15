const mysql = require('mysql2');

const connection = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: 'root',
    database: 'aws_db'
});

connection.connect((err) => {
    if (err) {
        console.error('Database connection failed: ' + err.stack);
        return;
    }
    console.log('Connected to database.');

    connection.query('SELECT * FROM teste', (err, results) => {
        if (err) throw err;
    
        results.forEach(result => {
            console.log(`${result.id} ${result.teste} ${result.createad_at}`);
        });

        connection.end();
    });
});
