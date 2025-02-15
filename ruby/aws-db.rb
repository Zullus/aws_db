require 'mysql2'

client = Mysql2::Client.new(
    :host => "127.0.0.1",
    :username => "root",
    :password => "root",
    :database => "aws_db"
)

results = client.query("SELECT * FROM teste")

results.each do |row|
    puts "#{row['id']} #{row['teste']} #{row['createad_at']}"

end

client.close