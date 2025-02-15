(defproject aws-db "0.1.0-SNAPSHOT"
  :description "MySQL connection example"
  :dependencies [[org.clojure/clojure "1.11.1"]
                 [mysql/mysql-connector-java "8.0.33"]
                 [org.clojure/java.jdbc "0.7.12"]]
  :main ^:skip-aot aws-db.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
