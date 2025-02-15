(ns aws-db.core
  (:require [clojure.java.jdbc :as jdbc])
  (:gen-class))

(def db-spec
  {:dbtype "mysql"
   :dbname "aws_db"
   :host "127.0.0.1"
   :user "root"
   :password "root"
   :useSSL false
   :useUnicode true
   :characterEncoding "UTF-8"})

(defn fetch-data []
  (try
    (let [query "SELECT * FROM teste"
          results (jdbc/query db-spec [query])]
      (doseq [row results]
        (println (str (:id row) " " (:teste row) " " (:createad_at row)))))
    (catch Exception e
      (println "Error:" (.getMessage e)))))

(defn -main [& args]
  (println "Connecting to database...")
  (fetch-data)
  (System/exit 0))