#!/bin/bash
SVR="localhost"
USR="sysadmin"
PASS="welcome1"
IN_DIR="/var/www/live/in"
OUT_DIR="/var/www/live/out"
echo "Cleaning up the in dir. $IN_DIR ..."
if [ -d $IN_DIR ]
then
	echo ""
else
	mkdir -p $IN_DIR
fi
rm $IN_DIR/*.xml
echo "Fetching the project files..."
curl -u $USR:$PASS http://${SVR}/idc/groups/grpcommercial/documents/system/ss_project_grpcommercial.xml > $IN_DIR/ss_project_grpcommercial.xml
curl -u $USR:$PASS http://${SVR}/idc/groups/grphr/documents/system/ss_project_grphr.xml > $IN_DIR/ss_project_grphr.xml
curl -u $USR:$PASS http://${SVR}/idc/groups/grpadt/documents/system/ss_project_grpadt.xml > $IN_DIR/ss_project_grpadt.xml
curl -u $USR:$PASS http://${SVR}/idc/groups/grpit/documents/system/ss_project_grpit.xml > $IN_DIR/ss_project_grpit.xml
curl -u $USR:$PASS http://${SVR}/idc/groups/bbrce/documents/system/ss_project_bbrce.xml > $IN_DIR/ss_project_bbrce.xml
curl -u $USR:$PASS http://${SVR}/idc/groups/grpshe/documents/system/ss_project_grpshe.xml > $IN_DIR/ss_project_grpshe.xml
echo "Cleaning up the out dir. $OUT_DIR ..."
if [ -d $OUT_DIR ]
then
	echo ""
else
	mkdir -p $OUT_DIR
fi
rm $OUT_DIR/*.xml
for FILE in $IN_DIR/*.xml; do
	echo "Converting $FILE ..."
        OUT_FILE=`echo $FILE | sed 's/in/out/g'`
	xsltproc -o $OUT_FILE fix_ss_proj.xsl $FILE 
done
echo "Done."
