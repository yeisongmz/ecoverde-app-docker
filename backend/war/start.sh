#!/bin/sh
set +e

echo "INICIANDO START.SH"


$GLASSFISH_HOME/bin/asadmin start-domain

echo "======================"
echo "Creating data source"
echo "======================"

$GLASSFISH_HOME/bin/asadmin create-jdbc-connection-pool \
    --restype javax.sql.DataSource \
    --datasourceclassname org.postgresql.ds.PGSimpleDataSource \
    --property "ServerName=db:PortNumber=5432:DatabaseName=$DB_NAME:User=$DB_USER:Password=$DB_PASS" \
    ecologiaPool
$GLASSFISH_HOME/bin/asadmin create-jdbc-resource --connectionpoolid ecologiaPool $DS_NAME

# Incrementar el tamanho max de memoria ocupable 
$GLASSFISH_HOME/bin/asadmin delete-jvm-options '-XX\:MaxPermSize=192m'
$GLASSFISH_HOME/bin/asadmin create-jvm-options '-XX\:MaxPermSize=2048m'

$GLASSFISH_HOME/bin/asadmin delete-jvm-options '-Xmx512m'
$GLASSFISH_HOME/bin/asadmin create-jvm-options '-Xmx2048m'

$GLASSFISH_HOME/bin/asadmin create-jvm-options '-Djdk.tls.maxCertificateChainLength=15'

# Permitir monitoreo jmx
#$GLASSFISH_HOME/bin/asadmin create-jvm-options '-Djava.rmi.server.hostname=localhost'
#$GLASSFISH_HOME/bin/asadmin create-jvm-options '-Dcom.sun.management.jmxremote'
#$GLASSFISH_HOME/bin/asadmin create-jvm-options '-Dcom.sun.management.jmxremote.authenticate=true'
#$GLASSFISH_HOME/bin/asadmin create-jvm-options '-Dcom.sun.management.jmxremote.port=8686'
#$GLASSFISH_HOME/bin/asadmin create-jvm-options '-Dcom.sun.management.jmxremote.ssl=false'

#$GLASSFISH_HOME/bin/asadmin create-jvm-options '-Dcom.sun.management.jmxremote.password.file=/jmxpfile.pass'
#$GLASSFISH_HOME/bin/asadmin create-jvm-options '-Dcom.sun.management.jmxremote.local.only=false'

echo "======================"
echo "Deploying"
echo "======================"
$GLASSFISH_HOME/bin/asadmin -u admin deploy --force war/ecologia-verde.war

echo "======================"
echo "Log"
echo "======================"
tail -n 900 -f $GLASSFISH_HOME/glassfish/domains/domain1/logs/server.log
